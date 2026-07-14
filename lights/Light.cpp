#define LOG_TAG "android.hardware.light@2.0-service"

#include <log/log.h>
#include "Light.h"
#include <fstream>

namespace android {
namespace hardware {
namespace light {
namespace V2_0 {
namespace implementation {

static constexpr const char* RED_LED_BRIGHTNESS = "/sys/class/leds/red/brightness";
static constexpr const char* RED_LED_TRIGGER    = "/sys/class/leds/red/trigger";
static constexpr const char* RED_LED_DELAY_ON   = "/sys/class/leds/red/delay_on";
static constexpr const char* RED_LED_DELAY_OFF  = "/sys/class/leds/red/delay_off";
static constexpr const char* LCD_BACKLIGHT      = "/sys/class/leds/lcd-backlight/brightness";

static void write_int(const char* path, int value) {
    std::ofstream stream(path);
    if (stream.is_open()) {
        stream << value << "\n";
    } else {
        ALOGE("Failed to write %d to %s", value, path);
    }
}

static void write_str(const char* path, const char* value) {
    std::ofstream stream(path);
    if (stream.is_open()) {
        stream << value << "\n";
    } else {
        ALOGE("Failed to write %s to %s", value, path);
    }
}

Light::Light() {}

Return<Status> Light::setLight(Type type, const LightState& state) {
    uint8_t alpha = (state.color >> 24) & 0xFF;
    uint8_t red   = (state.color >> 16) & 0xFF;
    uint8_t green = (state.color >> 8)  & 0xFF;
    uint8_t blue  = state.color         & 0xFF;

    int light = ((77 * red) + (150 * green) + (29 * blue)) >> 8;
    int brightness = (alpha > 0) ? alpha : light;

    if (type == Type::BACKLIGHT) {
        write_int(LCD_BACKLIGHT, light);
        return Status::SUCCESS;
    }

    if (type == Type::NOTIFICATIONS || type == Type::BATTERY) {
        if (light > 0) {
            if (state.flashMode != Flash::NONE) {
                write_str(RED_LED_TRIGGER, "timer");
                write_int(RED_LED_BRIGHTNESS, brightness);
                write_int(RED_LED_DELAY_OFF, state.flashOffMs);
                write_int(RED_LED_DELAY_ON, state.flashOnMs);
            } else {
                write_str(RED_LED_TRIGGER, "none");
                write_int(RED_LED_BRIGHTNESS, brightness);
            }
        } else {
            write_str(RED_LED_TRIGGER, "none");
            write_int(RED_LED_BRIGHTNESS, 0);
        }
        return Status::SUCCESS;
    }

    return Status::LIGHT_NOT_SUPPORTED;
}

Return<void> Light::getSupportedTypes(getSupportedTypes_cb _hidl_cb) {
    std::vector<Type> types = {
        Type::BACKLIGHT,
        Type::BATTERY,
        Type::NOTIFICATIONS
    };
    hidl_vec<Type> hidl_types;
    hidl_types.setToExternal(types.data(), types.size());
    _hidl_cb(hidl_types);
    return Void();
}

}  // namespace implementation
}  // namespace V2_0
}  // namespace light
}  // namespace hardware
}  // namespace android
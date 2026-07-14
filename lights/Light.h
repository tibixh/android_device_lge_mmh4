#pragma once

#include <android/hardware/light/2.0/ILight.h>
#include <hidl/Status.h>

namespace android {
namespace hardware {
namespace light {
namespace V2_0 {
namespace implementation {

using ::android::hardware::Return;
using ::android::hardware::Void;
using ::android::hardware::light::V2_0::ILight;
using ::android::hardware::light::V2_0::LightState;
using ::android::hardware::light::V2_0::Type;
using ::android::hardware::light::V2_0::Status;

struct Light : public ILight {
    Light();
    Return<Status> setLight(Type type, const LightState& state) override;
    Return<void> getSupportedTypes(getSupportedTypes_cb _hidl_cb) override;
};

}  // namespace implementation
}  // namespace V2_0
}  // namespace light
}  // namespace hardware
}  // namespace android
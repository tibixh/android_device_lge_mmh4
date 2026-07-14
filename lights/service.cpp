#define LOG_TAG "android.hardware.light@2.0-service"

#include <hidl/HidlSupport.h>
#include <hidl/LegacySupport.h>
#include "Light.h"

using android::hardware::light::V2_0::implementation::Light;
using android::hardware::configureRpcThreadpool;
using android::hardware::joinRpcThreadpool;

int main() {
    android::sp<Light> service = new Light();
    configureRpcThreadpool(1, true);
    if (service->registerAsService() != android::OK) {
        ALOGE("Can't register Light HAL service");
        return 1;
    }
    joinRpcThreadpool();
    return 0;
}
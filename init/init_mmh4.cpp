#include <vector>
#include <string>
#include <android-base/properties.h>

#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <sys/_system_properties.h>

// Helper function to bypass the read-only restriction on ro.* properties
void property_override(char const prop[], char const value[]) {
    prop_info *pi = (prop_info*) __system_property_find(prop);
    if (pi) {
        __system_property_update(pi, value, strlen(value));
    } else {
        __system_property_add(prop, strlen(prop), value, strlen(value));
    }
}

void vendor_load_properties() {
    // Intercept the bootloader's forced hardware name
    // and override it with the generic chip ID
    property_override("ro.hardware", "mt6765");
}
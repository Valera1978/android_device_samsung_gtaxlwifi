#include <stdio.h>
#include <stdlib.h>

#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <sys/_system_properties.h>

#include "log.h"
#include "property_service.h"
#include "util.h"
#include "vendor_init.h"

static void property_override(char const prop[], char const value[]) {
    prop_info *pi;

    pi = (prop_info*) __system_property_find(prop);
    if (pi)
        __system_property_update(pi, value, strlen(value));
    else
        __system_property_add(prop, strlen(prop), value, strlen(value));
}

void vendor_load_properties()
{
    property_override("ro.product.model", "SM-T585");
    property_override("ro.product.device", "gtaxllte");
    property_override("ro.product.name", "gtaxlltexx");
    property_override("ro.build.product", "gtaxllte");
    property_override("ro.build.description", "gtaxlltexx-user 7.0 NRD90M T585XXU2BQE4 release-keys");
    property_override("ro.build.fingerprint", "samsung/gtaxlltexx/gtaxllte:7.0/NRD90M/T585XXU2BQE4:user/release-keys");
}

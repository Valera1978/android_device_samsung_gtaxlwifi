/*
 * Copyright (C) 2008 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef ANDROID_SENSORS_H
#define ANDROID_SENSORS_H

#include <stdint.h>
#include <errno.h>
#include <sys/cdefs.h>
#include <sys/types.h>

#include <linux/input.h>

#include <hardware/hardware.h>
#include <hardware/sensors.h>

__BEGIN_DECLS

/*****************************************************************************/

#define ARRAY_SIZE(a) (sizeof(a) / sizeof(a[0]))

#define LOG_TAG "sensorscpp"

enum {
    ID_GY = 0,
    ID_RG,
    ID_A,
    ID_M,
    ID_RM,
    ID_PS,
    ID_O,
    ID_RV,
    ID_GRV,
    ID_LA,
    ID_GR,
    ID_SM,
    ID_P,
    ID_SC,
    ID_GMRV,
    ID_SO,
    ID_L = 0x100,
    ID_PX
};

/*****************************************************************************/

/*
 * The SENSORS Module
 */

/* the CM3663 is a binary proximity sensor that triggers around 6 cm on
 * this hardware */
#define PROXIMITY_THRESHOLD_CM  6.0f

/*****************************************************************************/

#define EVENT_TYPE_ACCEL_X          REL_X
#define EVENT_TYPE_ACCEL_Y          REL_Y
#define EVENT_TYPE_ACCEL_Z          REL_Z
#define EVENT_TYPE_ACCEL_HI         REL_DIAL
#define EVENT_TYPE_ACCEL_LO         REL_MISC

#define EVENT_TYPE_LIGHT            REL_MISC

/*****************************************************************************/

__END_DECLS

#endif  // ANDROID_SENSORS_H

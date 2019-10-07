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

#include <fcntl.h>
#include <errno.h>
#include <math.h>
#include <poll.h>
#include <unistd.h>
#include <stdlib.h>
#include <dirent.h>
#include <sys/select.h>
#include <linux/ioctl.h>
#include <linux/types.h>
#include <linux/uinput.h>
#include <cutils/log.h>
#include <cstring>

#include "AccelSensor.h"

// come from kernel - drivers/sensors/k2hh.c
#define MAX_ACCEL_1G          8192
#define ACCEL_VALUE_COEFF     (1.f * GRAVITY_EARTH / MAX_ACCEL_1G)

//#define TIME_LO_MASK 0x00000000FFFFFFFF
//#define TIME_HI_MASK 0xFFFFFFFF00000000
//#define TIME_HI_SHIFT 32

/*****************************************************************************/
AccelSensor::AccelSensor()
    : SensorBase(NULL, "accelerometer_sensor"),
    mEnabled(0),
    mInputReader(4),
    mIsInitialize(false)
{
    memset(&mPendingEvent, 0, sizeof(mPendingEvent));

    mPendingEvent.version = sizeof(sensors_event_t);
    mPendingEvent.sensor = ID_A;
    mPendingEvent.type = SENSOR_TYPE_ACCELEROMETER;
    mPendingEvent.acceleration.status = SENSOR_STATUS_ACCURACY_HIGH;

    if (data_fd) {
        strcpy(input_sysfs_path, "/sys/class/input/");
        strcat(input_sysfs_path, input_name);
        strcat(input_sysfs_path, "/device/");
        input_sysfs_path_len = strlen(input_sysfs_path);
    }
}

AccelSensor::~AccelSensor() {
    if (mEnabled) {
        enable(0, 0);
    }
}

int AccelSensor::setInitialState(int32_t handle) {
    if (mIsInitialize)
        return 0;

    setDelay(handle, 66667000);

    int fd = open("/sys/class/sensors/accelerometer_sensor/calibration", O_RDWR);
    if (fd >= 0) {
        write(fd, "0", 2);
        close(fd);
    }

    strcpy(&input_sysfs_path[input_sysfs_path_len], "enable");
    fd = open(input_sysfs_path, O_RDWR);
    if (fd >= 0) {
        write(fd, "1", 2);
        close(fd);
    }

    mIsInitialize = true;
    return 0;
}

int AccelSensor::setDelay(int32_t handle, int64_t ns)
{
    int fd;

    strcpy(&input_sysfs_path[input_sysfs_path_len], "poll_delay");
    fd = open(input_sysfs_path, O_RDWR);
    if (fd >= 0) {
        char buf[80];
        sprintf(buf, "%lld", ns);
        write(fd, buf, strlen(buf)+1);
        close(fd);
        return 0;
    }
    return -1;
}

int AccelSensor::enable(int32_t handle, int en) {
    setInitialState(handle);
    mEnabled = en ? 1 : 0;
    return 0;
}

bool AccelSensor::hasPendingEvents() const {
    return false;
}

int AccelSensor::readEvents(sensors_event_t *data, int count)
{
    if (count < 1)
        return -EINVAL;

    ssize_t n = mInputReader.fill(data_fd);
    if (n < 0)
        return n;
    int numEventReceived = 0;
    input_event const* event;

    while (count && mInputReader.readEvent(&event)) {
        int type = event->type;
        if (type == EV_REL) {
            if (event->code == EVENT_TYPE_ACCEL_X)
                mPendingEvent.acceleration.x = ACCEL_VALUE_COEFF * event->value;
            else if (event->code == EVENT_TYPE_ACCEL_Y)
                mPendingEvent.acceleration.y = ACCEL_VALUE_COEFF * event->value;
            else if (event->code == EVENT_TYPE_ACCEL_Z)
                mPendingEvent.acceleration.z = ACCEL_VALUE_COEFF * event->value;
/*            else if (event->code == EVENT_TYPE_ACCEL_HI) {
                int64_t timestamp = event->value;
                mPendingEvent.timestamp = (timestamp << TIME_HI_SHIFT) + (mPendingEvent.timestamp & TIME_LO_MASK);
            }
            else if (event->code == EVENT_TYPE_ACCEL_LO)
                mPendingEvent.timestamp = (mPendingEvent.timestamp & TIME_HI_SHIFT) + event->value; */
        } else if (type == EV_SYN) {
            mPendingEvent.timestamp = timevalToNano(event->time);
            if (mEnabled) {
                *data++ = mPendingEvent;
                count--;
                numEventReceived++;
            }
        } else
            ALOGE("AccelerometerSensor: unknown event (type=%d, code=%d)",
                    type, event->code);

        mInputReader.next();
    }

    return numEventReceived;
}

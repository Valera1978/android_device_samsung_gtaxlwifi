Device configuration for the Samsung Galaxy Tab A

Copyright (C) 2017 The LineageOS Project
Copyright (C) 2017 Valera Chigir <valera1978@tut.by>

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

------------------------------------------------------------------

* Description

  This repository is for LineageOS on Samsung Galaxy Tab A (gtaxllte)

* How To Build LineageOS for Samsung Galaxy Tab A

  - Make a workspace

mkdir cm15
cd cm15

  - Do repo init & sync

repo init -u git://github.com/LineageOS/android.git -b lineage-15.1

  - Create .repo/local_manifests/roomservice.xml with the following content:

```
<?xml version="1.0" encoding="UTF-8"?>
<manifest>

  <project name="Valera1978/android_device_samsung_gtaxllte" path="device/samsung/gtaxllte" remote="github" revision="lineage-15.1" />
  <project name="Valera1978/android_kernel_samsung_exynos7870" path="kernel/samsung/exynos7870" remote="github" revision="lineage-15.0_perm" />
  <project name="Valera1978/android_vendor_samsung_gtaxllte" path="vendor/samsung/gtaxllte" remote="github" revision="lineage-15.1" />

  <project name="TeamNexus/android_hardware_samsung_slsi-cm_exynos7870" path="hardware/samsung_slsi-cm/exynos7870" remote="github" revision="nx-8.0" />
  <project name="ivanmeler/android_hardware_samsung_slsi-cm_exynos" path="hardware/samsung_slsi-cm/exynos" remote="github" revision="lineage-15.0" />
  <project name="ivanmeler/android_hardware_samsung_slsi-cm_exynos5" path="hardware/samsung_slsi-cm/exynos5" remote="github" revision="lineage-15.1" />
  <project name="ivanmeler/android_hardware_samsung_slsi-cm_openmax" path="hardware/samsung_slsi-cm/openmax" remote="github" revision="lineage-15.1" />
  <project name="ivanmeler/android_hardware_samsung" path="hardware/samsung" remote="github" revision="lineage-15.1" />

</manifest>
```

repo sync

  - Copy proprietary vendor files

  There are two options to to that. Connect your device with adb enabled and run:

./extract-files.sh

  Or if you have the system image unpacked on your disk, then simply run:

    STOCK_ROM_DIR=/path/to/system ./extract-files.sh

  - Setup environment

. build/envsetup.sh

  - Build cm15

brunch gtaxllte

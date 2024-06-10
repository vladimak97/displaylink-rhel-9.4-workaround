# Red Hat Enterprise Linux DisplayLink Driver: A Workaround Guide

## Installation Steps

### 1. Install Dependencies

First, ensure that your system has all the necessary development tools and kernel headers installed. These are essential for building and compiling the DisplayLink driver components:

sudo dnf install kernel-devel kernel-headers gcc make

### 2. Add the EPEL Repository

The Extra Packages for Enterprise Linux (EPEL) repository contains additional packages that are not included in the default Red Hat repositories. Since `epel-release` is required and not found in the default repositories, you need to add it manually by downloading and installing the repository package:

```bash
sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
```

### 3. Install DKMS

Dynamic Kernel Module Support (DKMS) is necessary to automatically rebuild the EVDI kernel module whenever the kernel is updated. With the EPEL repository added, you can install the `dkms` package:

```bash
sudo dnf install dkms
```

### 4. Install EVDI (Extensible Virtual Display Interface)

The EVDI module is required for DisplayLink to function correctly. You need to download the source code from the official repository, compile it, and then install it on your system. Navigate to your `Downloads` directory, clone the EVDI repository, build the module, and install it:

```bash
cd ~/Downloads
git clone https://github.com/DisplayLink/evdi.git
cd evdi
make
sudo make install
```

### 5. Install the DisplayLink Driver

After installing EVDI, you will need to install the DisplayLink driver package. Since I could not find a specific DisplayLink driver for Red Hat Enterprise Linux 9.4, you can use the one for CentOS Stream 9 (https://github.com/displaylink-rpm/displaylink-rpm/releases), which is compatible. Just navigate to the directory containing the RPM file and use dnf to install it. This package includes all the required drivers for the DisplayLink hardware:

```bash
cd ~/Downloads
sudo dnf install ./centos-stream-stream9-displaylink-1.14.4-2.github_evdi.x86_64.rpm
```

### 6. Verify the Installation

To ensure that the DisplayLink driver was installed correctly, use the `rpm` command to query the installed package. This step confirms that the driver is present on your system:

```bash
rpm -q centos-stream-stream9-displaylink
```

### 7. Load the EVDI Kernel Module

Manually load the EVDI kernel module into the running kernel. This step is necessary to enable the DisplayLink driver to interact with the system's display hardware:

```bash
sudo modprobe evdi
```

### 8. Restart Your System

Rebooting your system ensures that all changes take effect and that the newly installed drivers and modules are properly initialized. This step is crucial for the final configuration to take place:

```bash
sudo reboot
```

### 9. Check Driver Functionality

After rebooting, verify that the DisplayLink driver is working by connecting your DisplayLink device. Check the display settings to ensure that the connected monitors are recognized and functioning correctly.

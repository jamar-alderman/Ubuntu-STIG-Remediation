# Lab Architecture and Constraints

## Known environment

NyxGuard runs on the `nyx0100` Rocky Linux 10 x86_64 VM. The documented scanner is OpenSCAP 1.4.4, using the RHEL 10 benchmark version 0.1.81 and the Rocky datastream listed in the [README](../README.md).

The earlier Ubuntu README mentioned KVM/QEMU and SSH management. Those details were not confirmed for this Rocky VM, so I have not carried them forward as current facts. Virtual disk sizes, LVM layout, interface addresses, hypervisor, and snapshot/recovery arrangements still need to be recorded. No topology or storage layout is invented here.

## Filesystem findings — ARCHITECTURAL CHANGE REQUIRED

The supplied findings request separate filesystems for `/home`, `/tmp`, `/var`, `/var/log`, `/var/log/audit`, and `/var/tmp`. Creating directories does not satisfy separate-filesystem requirements.

Resolution may involve additional virtual disks, repartitioning, LVM changes, or rebuilding the VM. Before choosing an approach I need the actual storage layout, capacity requirements, a backup, and a tested recovery route. Data migration must preserve ownership, permissions, and relevant metadata. The final evidence should show the mounted layout and the corresponding rescan results. No storage changes are documented as performed.

## FIPS findings — PLATFORM LIMITATION where certification is required

The benchmark caveat supplied with the lab notes says Rocky Linux does not inherit RHEL certifications or evaluations. A configured cryptographic mode is not proof of certification. Certification-dependent findings remain platform limitations; individual configurable hashing or crypto-policy findings still need investigation and are not automatically exempted.

For each affected rule I need its exact requirement, local observations, and OpenSCAP result before deciding whether the problem is configuration, check compatibility, or certification. No FIPS result has been converted to PASS or NOT APPLICABLE.

## Recovery planning

GRUB, authentication, network, and filesystem changes can interrupt access or boot. Before those work groups, confirm console access and a usable recovery method, then document a rollback plan. This is planned preparation, not a claim that a snapshot or backup already exists.

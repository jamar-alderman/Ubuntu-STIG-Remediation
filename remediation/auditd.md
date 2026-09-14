# auditd

Status: **PENDING**. This page is a work plan, not a completed remediation.

## Known Findings

The initial summary had approximately 93 audit-related failures, including 83 under comprehensive auditing. The groups overlap. No generated rule set has been applied as part of this repository work.

chmod/chown operations; file deletion; SELinux administrative commands; failed file access; kernel module loading/unloading; login/logout; privileged commands; sudoers changes; user/group database changes; audit storage; failure behavior; immutability; boot-time auditing; backlog configuration.

## Planned Investigation

Split the findings into event coverage, storage/failure behavior, and boot/runtime settings. Inspect existing rules and logs first. Plan carefully around immutable rules and settings that can halt the VM or require a reboot.

## Validation Needed

For each small group, capture the loaded configuration and a relevant event where appropriate, then compare the exact OpenSCAP rule result. Do not claim completion from a file containing dozens of generated rules.

Exact rule IDs and severities have not been supplied. Track results in the [findings tracker](../tracking/findings.md) using the [methodology](../documentation/methodology.md).

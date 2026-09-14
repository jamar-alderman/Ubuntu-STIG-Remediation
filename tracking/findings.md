# Findings Tracker

This tracker records supplied findings and validation gaps. Titles are used because exact STIG/XCCDF rule IDs and individual severities were not supplied. Group rows are planning summaries, not a complete rule export, and must not be used to calculate scan scores.

## Status Legend

| Status | Meaning |
| --- | --- |
| VERIFIED | Validation evidence supports the result; the existing entries cite lab-owner-reported OpenSCAP PASS observations |
| IN PROGRESS | Investigation or remediation is underway with recorded work |
| PENDING | Identified work without a documented validated fix |
| NOT APPLICABLE | Applicability reviewed and an explanation recorded |
| PLATFORM LIMITATION | A distribution or certification constraint prevents satisfying the requirement as written |
| ARCHITECTURAL CHANGE REQUIRED | Resolution needs a storage or design change, rather than a simple setting |
| ACCEPTED LAB RISK | A specific risk has been consciously accepted with a rationale and revisit condition |

The overall lab is IN PROGRESS. No individual finding has yet been assigned NOT APPLICABLE or ACCEPTED LAB RISK. Unknown severity is not the same thing as the scan's “Other” severity category.

## Findings

| Rule / Finding | Severity | Subsystem | Initial Result | Current Status | Validation | Documentation | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Disable Ctrl-Alt-Del Burst Action | Not supplied | Boot / systemd | Not supplied | VERIFIED | Later OpenSCAP PASS reported by lab owner; artifact pending | [Boot / systemd](../remediation/ctrl-alt-del.md) | Exact scan milestone unknown; confirmed manual remediation documented |
| Disable Ctrl-Alt-Del Reboot Activation | Not supplied | Boot / systemd | Not supplied | VERIFIED | Later OpenSCAP PASS reported by lab owner; artifact pending | [Boot / systemd](../remediation/ctrl-alt-del.md) | Exact scan milestone unknown; confirmed manual remediation documented |
| Verify that Interactive Boot is Disabled | Not supplied | Boot / systemd | Not supplied | VERIFIED | Later OpenSCAP PASS reported by lab owner; artifact pending | [Boot / systemd](../remediation/ctrl-alt-del.md) | Exact scan milestone unknown; related observation, change sequence not supplied |
| Require Authentication for Single User Mode | Not supplied | Boot / systemd | Not supplied | VERIFIED | Later OpenSCAP PASS reported by lab owner; artifact pending | [Boot / systemd](../remediation/ctrl-alt-del.md) | Exact scan milestone unknown; related observation, change sequence not supplied |
| Install AIDE | Not supplied | AIDE | AIDE group: 8/8 failed | PENDING | Current failure reported; no validated fix | [AIDE](../remediation/aide.md) | Group baseline does not supply individual rule metadata |
| Build and Test AIDE Database | Not supplied | AIDE | AIDE group: 8/8 failed | PENDING | Current failure reported; no validated fix | [AIDE](../remediation/aide.md) | Group baseline does not supply individual rule metadata |
| Configure AIDE to Verify Audit Tools | Not supplied | AIDE | AIDE group: 8/8 failed | PENDING | Current failure reported; no validated fix | [AIDE](../remediation/aide.md) | Group baseline does not supply individual rule metadata |
| Configure Periodic Execution of AIDE | Not supplied | AIDE | AIDE group: 8/8 failed | PENDING | Current failure reported; no validated fix | [AIDE](../remediation/aide.md) | Group baseline does not supply individual rule metadata |
| Configure Post-Scan Notifications | Not supplied | AIDE | AIDE group: 8/8 failed | PENDING | Current failure reported; no validated fix | [AIDE](../remediation/aide.md) | Group baseline does not supply individual rule metadata |
| FIPS-compatible hashing requirements | Not supplied | AIDE | AIDE group: 8/8 failed | PENDING | Current failure reported; no validated fix | [AIDE](../remediation/aide.md) | Exact rule text/ID needs report confirmation; certification and hashing configuration are distinct |
| ACL verification | Not supplied | AIDE | AIDE group: 8/8 failed | PENDING | Current failure reported; no validated fix | [AIDE](../remediation/aide.md) | Group baseline does not supply individual rule metadata |
| Extended attribute verification | Not supplied | AIDE | AIDE group: 8/8 failed | PENDING | Current failure reported; no validated fix | [AIDE](../remediation/aide.md) | Group baseline does not supply individual rule metadata |
| Comprehensive auditing: chmod/chown, deletion, failed access, SELinux commands, modules, login/logout, privileged commands, sudoers, user/group files | Not supplied | auditd | Approx. 83 group failures | PENDING | No validated fix supplied | [auditd](../remediation/auditd.md) | Subset of approx. 93 audit-related failures |
| Audit storage, failure behavior, immutability, boot-time auditing, backlog | Not supplied | auditd | Approx. 93 audit-related group failures | PENDING | No validated fix supplied | [auditd](../remediation/auditd.md) | Individual initial results not supplied; group overlaps comprehensive auditing |
| pam_faillock: logging, thresholds, persistence, intervals, duration | Not supplied | PAM | Approx. 50 account/access group failures | PENDING | No validated fix supplied | [PAM](../remediation/pam.md) | No exact values or individual rule results supplied |
| Password length, complexity, character classes, hashing, age, inactivity | Not supplied | PAM | Account/access group failures | PENDING | No validated fix supplied | [PAM](../remediation/pam.md) | No validated password-policy changes supplied |
| pam_wheel, timeout, login delay, umask | Not supplied | PAM | Account/access group failures | PENDING | No validated fix supplied | [PAM](../remediation/pam.md) | Applicability and effective configuration need review |
| SSH authentication, sessions, forwarding, banners, and logging | Not supplied | SSH | Approx. 20 group failures | PENDING | No validated fix supplied | [SSH](../remediation/ssh.md) | Full supplied list is in the linked plan |
| IP forwarding, redirects, routing, ICMP behavior, reverse-path filtering, SYN cookies | Not supplied | Network | Approx. 28 network/firewall group failures | PENDING | No validated fix supplied | [Network](../remediation/sysctl.md) | Individual values and results not supplied |
| CAN, SCTP, TIPC, Bluetooth, DNS | Not supplied | Network | Not supplied individually | PENDING | No validated fix supplied | [Network](../remediation/sysctl.md) | Not all network findings are sysctl parameters |
| firewalld default zone | Not supplied | Firewall | Not supplied individually | PENDING | No validated fix supplied | [Firewall](../remediation/firewalld.md) | Zone and interface evidence needed |
| GRUB administrator username | Not supplied | Boot | Not supplied individually | PENDING | Remaining finding reported; no validated fix | [Boot](../remediation/boot-security.md) | Console recovery and boot planning required |
| GRUB password | Not supplied | Boot | Not supplied individually | PENDING | Remaining finding reported; no validated fix | [Boot](../remediation/boot-security.md) | Console recovery and boot planning required |
| init_on_free | Not supplied | Boot | Not supplied individually | PENDING | Remaining finding reported; no validated fix | [Boot](../remediation/boot-security.md) | Console recovery and boot planning required |
| KPTI | Not supplied | Boot | Not supplied individually | PENDING | Remaining finding reported; no validated fix | [Boot](../remediation/boot-security.md) | Console recovery and boot planning required |
| vsyscalls | Not supplied | Boot | Not supplied individually | PENDING | Remaining finding reported; no validated fix | [Boot](../remediation/boot-security.md) | Console recovery and boot planning required |
| File permissions and masks | Not supplied | Permissions | Approx. 20 group failures | PENDING | No validated fix supplied | [Permissions](../documentation/methodology.md) | Affected files/services and exact rules still needed |
| Service hardening | Not supplied | Services | Approx. 45 group failures | PENDING | No validated fix supplied | [Services](../documentation/methodology.md) | Affected files/services and exact rules still needed |
| Separate filesystem for `/home` | Not supplied | Storage | Not supplied individually | ARCHITECTURAL CHANGE REQUIRED | Architectural finding supplied; layout evidence pending | [Storage](../documentation/architecture.md) | May require disks, repartitioning, LVM changes, or VM rebuild |
| Separate filesystem for `/tmp` | Not supplied | Storage | Not supplied individually | ARCHITECTURAL CHANGE REQUIRED | Architectural finding supplied; layout evidence pending | [Storage](../documentation/architecture.md) | May require disks, repartitioning, LVM changes, or VM rebuild |
| Separate filesystem for `/var` | Not supplied | Storage | Not supplied individually | ARCHITECTURAL CHANGE REQUIRED | Architectural finding supplied; layout evidence pending | [Storage](../documentation/architecture.md) | May require disks, repartitioning, LVM changes, or VM rebuild |
| Separate filesystem for `/var/log` | Not supplied | Storage | Not supplied individually | ARCHITECTURAL CHANGE REQUIRED | Architectural finding supplied; layout evidence pending | [Storage](../documentation/architecture.md) | May require disks, repartitioning, LVM changes, or VM rebuild |
| Separate filesystem for `/var/log/audit` | Not supplied | Storage | Not supplied individually | ARCHITECTURAL CHANGE REQUIRED | Architectural finding supplied; layout evidence pending | [Storage](../documentation/architecture.md) | May require disks, repartitioning, LVM changes, or VM rebuild |
| Separate filesystem for `/var/tmp` | Not supplied | Storage | Not supplied individually | ARCHITECTURAL CHANGE REQUIRED | Architectural finding supplied; layout evidence pending | [Storage](../documentation/architecture.md) | May require disks, repartitioning, LVM changes, or VM rebuild |
| Certification-dependent FIPS requirements | Not supplied | Platform | Not supplied individually | PLATFORM LIMITATION | Supplied Rocky benchmark certification caveat | [Platform](../documentation/architecture.md) | Rocky does not inherit RHEL certifications; review each exact rule before classification |

## Evidence to Add Next

Attach reviewed local verification and later PASS excerpts for Ctrl+Alt+Del, identify their scan milestone, and preserve the original scan metadata privately. Resolve the [462-versus-463 result discrepancy](../scans/progress/README.md#comparison-limits) from the reports. Replace group rows with exact rule records as evidence becomes available, without inventing IDs, severities, or completion results.

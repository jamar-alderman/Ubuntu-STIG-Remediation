# Project NyxGuard

**Rocky Linux 10 OpenSCAP STIG-Aligned Hardening Lab**

## Overview

I started NyxGuard with a Rocky Linux 10 VM that scored 46.56% against the OpenSCAP RHEL 10 STIG profile. I am working through the findings by subsystem so I understand what each control changes, why it exists, and how to verify it myself.

My first documented scan had 176 passing rules and 278 failures. Later scans increased the score to 52.25% and then 55.11%. I am tracking each round of remediation so I can compare the results instead of running a generated remediation script and calling the system hardened.

The goal is not to force a fake 100% score. Some findings may not apply, some require architectural changes, and some involve Rocky Linux platform limitations. Those need documented decisions, not automatic changes.

Repository rename pending: the GitHub repository is currently named `Ubuntu-STIG-Remediation`. Its intended name is `NyxGuard-STIG-Remediation`; the project documented here is Rocky Linux 10. Renaming requires a manual repository settings change because the connected tooling does not expose that operation.

## Why I Built This

I wanted to learn Linux administration and security by actually hardening a system. For each finding, I want to understand why it failed, what part of Linux it affects, what fixes it, what the command does, and whether both my local checks and OpenSCAP agree afterward. I am keeping the mistakes and troubleshooting in the record too.

## Lab Environment

| Component | Documented value |
| --- | --- |
| Hostname | nyx0100 |
| Operating system | Rocky Linux 10 |
| Architecture | x86_64 |
| Environment | Virtual machine |
| OpenSCAP | 1.4.4 |
| Benchmark | RHEL 10 |
| Benchmark version | 0.1.81 |
| Profile | `xccdf_org.ssgproject.content_profile_stig` |
| Datastream | `/usr/share/xml/scap/ssg/content/ssg-rl10-ds.xml` |

See [architecture and constraints](documentation/architecture.md). The current VM's hypervisor and storage layout have not been supplied.

## Important OpenSCAP / Rocky Linux Caveat

The report describes this profile as based on what was expected in the RHEL 10 STIG. The official DISA RHEL 10 STIG was not available when this content was released. This lab therefore documents **Rocky Linux 10 evaluated against the OpenSCAP RHEL 10 STIG profile**, not implementation of an official DISA RHEL 10 STIG. This is a statement about the content's release, not about availability of newer benchmarks today.

The benchmark is a RHEL port modified to run on Rocky Linux. Rocky is not an exact copy of RHEL, so checks may produce false positives or false negatives. Rocky Linux does not inherit RHEL certifications or evaluations; certification-dependent controls, including some FIPS findings, may remain unresolved even after configuration changes. This VM is not claimed to be DISA certified, RHEL certified, or fully STIG compliant.

## Initial Baseline

The initial documented baseline is **46.56%: 176 passed, 278 failed, and 9 other/not checked**. Failure severity was 12 high, 248 medium, 17 low, and 1 other. See the [baseline record](scans/baseline/README.md).

## Compliance Progress

| Milestone | Score | Passed | Failed | Other |
| --- | ---: | ---: | ---: | ---: |
| Initial Baseline | 46.56% | 176 | 278 | 9 |
| Progress Scan 1 | 52.25% | 177 | 276 | 9 |
| Progress Scan 2 | 55.11% | 181 | 273 | 9 |
| Current | TBD | TBD | TBD | TBD |

**46.56% → 52.25% → 55.11%** is the verified progression reported in my lab notes. **55.11% remains the most recent verified score**; “Current” reserves a row for a new scan that has not been provided.

Evidence provenance: these figures and the PASS results below were supplied from my scan history during this documentation update. Raw HTML/XML reports, scan dates, and screenshots were not present in the repository. These are transcribed summaries, not an independent rescan. The totals are preserved as supplied: Progress Scan 1 totals 462 results, while the other two total 463. I need the original reports to explain that difference. Scores are not recalculated from pass counts. See [progress records and severity](scans/progress/README.md).

## Where I Started

| Initial area | Approximate failures |
| --- | ---: |
| auditd / system accounting | 93 |
| Comprehensive audit rules (within auditing) | 83 |
| Account and access control | 50 |
| Services | 45 |
| Network / firewall | 28 |
| SSH | 20 |
| File permissions / masks | 20 |
| AIDE | 8 of 8 checks |

These groups overlap and should not be added together. auditd was the largest group. I started with smaller groups to learn the workflow before taking on the larger audit rule set.

## Remediation Methodology

OpenSCAP finding → understand the control → inspect existing configuration → apply remediation → verify locally → run OpenSCAP again → compare scans → document the result.

The [methodology](documentation/methodology.md) explains the evidence and review process. I do not treat a command completing successfully as proof that its control passes.

## Verified Remediations

[Ctrl+Alt+Del hardening](remediation/ctrl-alt-del.md) documents setting `CtrlAltDelBurstAction=none` and masking `ctrl-alt-del.target`, including the permission error and duplicate entries encountered along the way.

| Control | Status | Evidence |
| --- | --- | --- |
| Disable Ctrl-Alt-Del Burst Action | VERIFIED | Later OpenSCAP PASS reported in lab notes |
| Disable Ctrl-Alt-Del Reboot Activation | VERIFIED | Later OpenSCAP PASS reported in lab notes |
| Verify that Interactive Boot is Disabled | VERIFIED | Related PASS reported; no remediation sequence supplied |
| Require Authentication for Single User Mode | VERIFIED | Related PASS reported; no remediation sequence supplied |

The related boot passes are observations, not evidence that Ctrl+Alt+Del changes caused them. The exact scan milestone for these passes has not been supplied.

## Current Work

The lab remains **IN PROGRESS**. I am organizing evidence and working through findings in groups. No additional subsystem is marked complete. The [findings tracker](tracking/findings.md) separates validation from planned work.

## Remediation Roadmap

| Area | Status | Next step |
| --- | --- | --- |
| [AIDE](remediation/aide.md) | PENDING | Work through installation, database, scheduling, and coverage findings |
| [auditd](remediation/auditd.md) | PENDING | Break down the audit rule and storage findings |
| [PAM and password policy](remediation/pam.md) | PENDING | Inspect authentication configuration and recovery access |
| [SSH](remediation/ssh.md) | PENDING | Review effective configuration and preserve access |
| [sysctl / network](remediation/sysctl.md) | PENDING | Identify applicable settings and persistent configuration |
| [firewalld](remediation/firewalld.md) | PENDING | Review active zones and required traffic |
| File permissions and service hardening | PENDING | Inventory affected files and services before changes |
| [GRUB / boot security](remediation/boot-security.md) | PENDING | Plan console recovery before bootloader edits |
| [Separate filesystems](documentation/architecture.md) | ARCHITECTURAL CHANGE REQUIRED | Plan storage changes, backups, and recovery |
| [Certification-dependent FIPS findings](documentation/architecture.md) | PLATFORM LIMITATION | Separate certification requirements from configurable settings |

## Repository Structure

- [scans](scans/README.md): baseline and progress summaries; publication review guidance.
- [scripts](scripts/README.md): reusable scan script and its full explanation.
- [documentation](documentation/methodology.md): architecture, methodology, command reference, and lessons learned.
- [remediation](remediation/ctrl-alt-del.md): verified Ctrl+Alt+Del work and subsystem plans.
- [tracking](tracking/findings.md): findings, statuses, and validation gaps.
- [screenshots](screenshots/README.md): evidence collection guidance; no screenshots yet.
- [CHANGELOG.md](CHANGELOG.md): real milestones without invented scan dates.

## Tools and Technologies

Rocky Linux 10, OpenSCAP, SCAP Security Guide content, Bash, systemd, sudo, grep, sed, and Python's temporary HTTP server appear in the documented workflow. AIDE, auditd, PAM, SSH, sysctl, firewalld, and GRUB are remediation areas, not claims of completed work. See the [command reference](documentation/command-reference.md).

## Lessons Learned

A script run as my normal user could not modify a root-owned configuration file. Running it with sudo addressed that permission problem. Repeated appends also left duplicate entries to clean up. Those experiences helped me understand privileges and why inspecting a file matters before and after editing it. See [lessons learned](documentation/lessons-learned.md).

## Disclaimer / Lab Context

This is an ongoing learning lab, not a production hardening prescription or certification. Changes that affect login, networking, boot, or storage need recovery planning. I record unresolved findings and accepted risks explicitly; no individual finding has been accepted as a lab risk or declared not applicable without a documented decision.

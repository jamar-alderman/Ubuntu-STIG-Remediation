# Project NyxGuard

**Rocky Linux 10 OpenSCAP STIG-Aligned Hardening Lab**

## Overview

I started NyxGuard with a Rocky Linux 10 VM that scored 46.56% against the OpenSCAP RHEL 10 STIG profile. I am working through the findings by subsystem so I understand what each control changes, why it exists, and how to verify it myself.

My first documented scan had 176 passing rules and 278 failures. Later scans increased the score to 52.25% and then 55.11%. I am tracking each round of remediation so I can compare the results instead of running a generated remediation script and calling the system hardened.

The goal is not to force a fake 100% score. Some findings may not apply, some require architectural changes, and some involve Rocky Linux platform limitations. Those need documented decisions, not automatic changes.

Repository rename pending: the GitHub repository is currently named `Ubuntu-STIG-Remediation`. Its intended name is `NyxGuard-STIG-Remediation`; the project documented here is Rocky Linux 10.

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

See [architecture and constraints](documentation/architecture.md).

## Important OpenSCAP / Rocky Linux Caveat

The report describes this profile as based on what was expected in the RHEL 10 STIG. This lab therefore documents **Rocky Linux 10 evaluated against the OpenSCAP RHEL 10 STIG profile**, not a claim that the VM is DISA certified, RHEL certified, or fully STIG compliant.

Rocky Linux is not an exact copy of RHEL, so some checks may produce false positives or false negatives. Certification-dependent controls may also remain unresolved even after configuration changes.

## Initial Baseline

The initial documented baseline is **46.56%: 176 passed, 278 failed, and 9 other/not checked**. Failure severity was 12 high, 248 medium, 17 low, and 1 other. See the [baseline record](scans/baseline/README.md).

## Compliance Progress

| Milestone | Score | Passed | Failed | Other |
| --- | ---: | ---: | ---: | ---: |
| Initial Baseline | 46.56% | 176 | 278 | 9 |
| Progress Scan 1 | 52.25% | 177 | 276 | 9 |
| Progress Scan 2 | 55.11% | 181 | 273 | 9 |
| Current | TBD | TBD | TBD | TBD |

**46.56% → 52.25% → 55.11%** is the verified progression reported in my lab notes. **55.11% remains the most recent verified score**.

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

These groups overlap and should not be added together.

## Remediation Methodology

OpenSCAP finding → understand the control → inspect existing configuration → apply remediation → verify locally → run OpenSCAP again → compare scans → document the result.

The [methodology](documentation/methodology.md) explains the evidence and review process. I do not treat a command completing successfully as proof that its control passes.

## Current Remediation Focus: SSH

The current documented remediation work is focused on SSH hardening. See [SSH hardening](remediation/ssh.md).

The SSH work currently documents:

- `PubkeyAuthentication yes` — allows SSH key-based authentication so the server can verify possession of the matching private key instead of relying only on reusable passwords.
- `LogLevel VERBOSE` — increases SSH authentication logging detail for troubleshooting, auditing, and incident review.
- `PermitRootLogin no` — blocks direct SSH access as `root`, requiring administrators to authenticate with a named account and elevate with `sudo`.

Each control includes the reason for the setting, the configured value, a local verification command using `sshd -T`, and a validation workflow. OpenSCAP revalidation evidence still needs to be attached before these controls are marked fully verified.

## Current Work

The lab remains **IN PROGRESS**. I am narrowing the repository to remediation work I have actually documented in detail rather than publishing placeholder pages for controls I have not yet worked through.

## Repository Structure

- [scans](scans/README.md): baseline and progress summaries.
- [scripts](scripts/README.md): reusable scan script and explanation.
- [documentation](documentation/methodology.md): architecture, methodology, command reference, and lessons learned.
- [SSH remediation](remediation/ssh.md): current SSH hardening work and validation steps.
- [tracking](tracking/findings.md): findings, statuses, and validation gaps.
- [screenshots](screenshots/README.md): evidence collection guidance.
- [CHANGELOG.md](CHANGELOG.md): project milestones.

## Tools and Technologies

Rocky Linux 10, OpenSCAP, SCAP Security Guide content, Bash, OpenSSH, `sshd`, sudo, grep, sed, systemd, and Python's temporary HTTP server appear in the documented workflow. See the [command reference](documentation/command-reference.md).

## Lessons Learned

The most useful part of this lab has been learning to separate a configuration change from proof that the control is actually effective. I inspect the configuration, verify the effective value, preserve recovery access when changing SSH settings, and use OpenSCAP rescans as the final validation step.

See [lessons learned](documentation/lessons-learned.md).

## Disclaimer / Lab Context

This is an ongoing learning lab, not a production hardening prescription or certification. Changes that affect authentication, networking, boot, or storage require recovery planning and verification.

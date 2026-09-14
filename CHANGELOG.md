# Changelog

Historical scan and remediation dates were not supplied. The entries below record known milestones without assigning invented dates or assuming which score increase came from which edit.

## Documented Lab Milestones — Dates Unknown

- Captured the original 46.56% OpenSCAP baseline: 176 passed, 278 failed, 9 other/not checked.
- Recorded Progress Scan 1 at 52.25%: 177 passed, 276 failed, 9 other.
- Recorded Progress Scan 2 at 55.11%: 181 passed, 273 failed, 9 other.
- Investigated Ctrl+Alt+Del behavior and the difference between burst action and target activation.
- Encountered permission errors running a remediation script as a normal user; running it with sudo permitted changes to the root-owned configuration file.
- Created duplicate burst-action entries during testing and used grep/sed concepts to investigate cleanup.
- Configured `CtrlAltDelBurstAction=none` and masked `ctrl-alt-del.target`.
- Recorded later OpenSCAP PASS observations for both Ctrl+Alt+Del controls, interactive boot disabled, and single-user authentication required. The exact scan milestone is not supplied.

## Repository Documentation Update

- Replaced the outdated Ubuntu introduction with Project NyxGuard, a Rocky Linux 10 OpenSCAP STIG-aligned hardening lab.
- Preserved the existing MIT license and useful hardening goals; removed two empty documentation placeholders.
- Added baseline and progress summaries with evidence provenance and the unresolved result-count difference.
- Added the supplied reusable scan script with documented banner and error-handling changes, plus a warning about its retained home-directory HTTP serving behavior.
- Added the detailed Ctrl+Alt+Del record, including actual troubleshooting and clearly labeled follow-up examples.
- Created the remediation methodology, findings tracker, command explanations, and lessons learned.
- Added plans for unfinished subsystems and recorded storage architecture and Rocky certification constraints.
- Added evidence collection guidance and raw-report ignore rules. No reports or screenshots were fabricated or published.
- Recorded the pending manual rename to `NyxGuard-STIG-Remediation`; connected tooling does not expose repository renaming.

These are documentation and script updates. No new scan, VM remediation, certification, or whole-subsystem completion is claimed.

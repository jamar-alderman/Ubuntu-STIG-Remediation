# AIDE

Status: **PENDING**. This page is a work plan, not a completed remediation.

## Known Findings

Eight of eight AIDE checks failed in the initial summary. No AIDE remediation has been validated.

Install AIDE; build and test its database; verify audit tools; configure periodic execution; configure post-scan notifications; investigate FIPS-compatible hashing, ACL verification, and extended attribute verification.

## Planned Investigation

Inspect the installed package and configuration, decide which paths and metadata need coverage, then establish a trusted database before scheduling comparisons. Keep certification-dependent issues separate from configurable hashing requirements.

## Validation Needed

Record database initialization and a controlled integrity test, review scheduling and notification behavior, and attach the corresponding OpenSCAP results. A scheduled command alone is not proof that the complete AIDE group passes.

Exact rule IDs and severities have not been supplied. Track results in the [findings tracker](../tracking/findings.md) using the [methodology](../documentation/methodology.md).

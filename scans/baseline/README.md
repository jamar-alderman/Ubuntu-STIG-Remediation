# Initial Baseline

Source: lab-owner-provided OpenSCAP scan summary. Scan date and raw artifact are not yet supplied.

| Score | Passed | Failed | Other / not checked |
| ---: | ---: | ---: | ---: |
| 46.56% | 176 | 278 | 9 |

| Failure severity | Count |
| --- | ---: |
| High | 12 |
| Medium | 248 |
| Low | 17 |
| Other | 1 |

This is the original documented starting point, not a later progress scan. The severity counts total 278 failures. The [initial subsystem groups](../../README.md#where-i-started) overlap and are approximate.

The documented environment is Rocky Linux 10 with OpenSCAP 1.4.4, benchmark RHEL 10 version 0.1.81, and profile `xccdf_org.ssgproject.content_profile_stig`. Per-scan metadata still needs confirmation against the original artifacts. Continue with the [progress scans](../progress/README.md).

# Remediation Methodology

I work through findings in groups so I can explain each change. A generated fix is something to read and understand first, not evidence that the system is secure.

## Workflow

1. **OpenSCAP finding:** record the title, original result, and exact ID and severity only if available.
2. **Understand the control:** read its rationale and applicability. Identify the subsystem and possible side effects.
3. **Inspect the existing configuration:** record relevant files, effective settings, ownership, and local observations. Do not substitute expected output for captured output.
4. **Apply remediation:** document what changed and why. Explain every command and plan rollback for changes that could affect access or boot.
5. **Verify locally:** inspect the resulting configuration and relevant behavior. A successful edit is not enough.
6. **Run OpenSCAP again:** keep the profile and content comparable, and record scanner/content versions if they change.
7. **Compare scan results:** record the score and result counts, but also compare individual rules. A score change alone does not identify which edit fixed a control.
8. **Document the result:** link evidence and troubleshooting from the finding's page and update the tracker.

## Evidence and statuses

Use the [tracker legend](../tracking/findings.md) consistently. VERIFIED requires validation evidence. Current verified entries rely on the lab owner's supplied later OpenSCAP PASS observations; raw artifacts have not yet been attached. Future entries should link a reviewed report excerpt or screenshot and local verification output, with the scan date and content version.

Use PENDING for identified work with no documented implementation, and IN PROGRESS when actual investigation or implementation is recorded. NOT APPLICABLE requires an applicability explanation. PLATFORM LIMITATION needs a distribution or certification constraint. ARCHITECTURAL CHANGE REQUIRED identifies storage or design work. ACCEPTED LAB RISK needs a specific decision, rationale, impact, and revisit condition. An unresolved failure is not automatically an accepted risk.

## Comparison limits

Preserve the supplied counts and scores. Do not infer missing rule results from totals or calculate a replacement score from the pass count. The [progress record](../scans/progress/README.md) records a one-result discrepancy that needs the original reports. Scan dates and rule IDs are currently unavailable. I will record those gaps rather than fill them with guesses.

## Publication and commit review

Before every commit, review all staged changes for passwords, tokens, API keys, authentication secrets, private keys (including SSH keys), certificates containing private material, tenant details, and personal information. Review reports and screenshots for usernames, hostnames, IP/MAC addresses, package inventories, filesystem paths, and other environment details. The intentionally documented lab hostname and standard configuration paths are part of the project context; additional identifying details should not be included by accident.

Keep original reports privately. Prefer reviewed Markdown summaries or redacted excerpts for publication. Check all relative Markdown links, confirm each completion claim has evidence, and review the diff before making a focused commit. The existing MIT license remains in place.

# firewalld

Status: **PENDING**. This page is a work plan, not a completed remediation.

## Known Findings

The supplied findings include the firewalld default zone; the exact current zone and required traffic were not supplied. No firewall remediation is verified.

Default-zone configuration and the relationship between required services, interface assignments, and active zones.

## Planned Investigation

Identify the actual interfaces, zone assignments, and required administration traffic. Compare runtime and persistent policy. Confirm console recovery before changing rules that could interrupt access.

## Validation Needed

Verify intended allowed and blocked traffic from an appropriate lab peer, confirm persistence, and capture the OpenSCAP result. The old Ubuntu README referenced UFW; it does not establish the current Rocky firewall state.

Exact rule IDs and severities have not been supplied. Track results in the [findings tracker](../tracking/findings.md) using the [methodology](../documentation/methodology.md).

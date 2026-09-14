# Network and sysctl Hardening

Status: **PENDING**. This page is a work plan, not a completed remediation.

## Known Findings

The initial network/firewall group had approximately 28 failures. No sysctl changes are documented as verified.

ICMP redirects; source routing; IPv4/IPv6 forwarding; reverse-path filtering; broadcast and bogus ICMP responses; TCP SYN cookies; sending redirects; IPv6 router advertisements and redirects; CAN; SCTP; TIPC; Bluetooth; DNS configuration.

## Planned Investigation

Determine whether the VM needs forwarding or any listed protocols. Separate runtime kernel parameters, persistent configuration, module controls, and DNS settings: these are not all sysctl changes. Inspect configuration precedence before writing values.

## Validation Needed

Record before/after effective values and their persistent source, confirm required connectivity, and rescan. Plan reboot verification where persistence matters. Do not copy a large parameter list without checking applicability.

Exact rule IDs and severities have not been supplied. Track results in the [findings tracker](../tracking/findings.md) using the [methodology](../documentation/methodology.md).

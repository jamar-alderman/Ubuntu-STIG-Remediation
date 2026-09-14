# SSH Hardening

Status: **PENDING**. This page is a work plan, not a completed remediation.

## Known Findings

The baseline contained approximately 20 SSH failures. No SSH configuration change is documented as verified.

ClientAliveCountMax; ClientAliveInterval; host-based authentication; compression; empty passwords; GSSAPI; Kerberos; .rhosts; root login; known-hosts behavior; X11 forwarding; environment options; public-key authentication; strict modes; warning banners; last-login display; session-key renegotiation; LogLevel VERBOSE; proxy display forwarding.

## Planned Investigation

Record active configuration, included files, and conditional settings. Match each finding to the installed server version. Confirm recovery access and preserve the existing session before changing authentication or reloading the service.

## Validation Needed

Check syntax, effective settings for the affected user/context, and a separate successful login before closing the original session. Then attach individual OpenSCAP results. The supplied titles do not establish exact current values.

Exact rule IDs and severities have not been supplied. Track results in the [findings tracker](../tracking/findings.md) using the [methodology](../documentation/methodology.md).

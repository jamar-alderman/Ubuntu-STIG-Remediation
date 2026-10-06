# SSH Hardening

Status: **IN PROGRESS**. The controls below are documented from the lab work completed so far. OpenSCAP revalidation evidence still needs to be attached before these controls are marked fully verified.

## Known Findings

The baseline contained approximately 20 SSH failures. The broader finding set includes ClientAliveCountMax; ClientAliveInterval; host-based authentication; compression; empty passwords; GSSAPI; Kerberos; .rhosts; root login; known-hosts behavior; X11 forwarding; environment options; public-key authentication; strict modes; warning banners; last-login display; session-key renegotiation; LogLevel VERBOSE; and proxy display forwarding.

## Documented Controls

### PubkeyAuthentication yes

**Why it matters**

`PubkeyAuthentication yes` allows SSH key-based authentication. Instead of relying only on a reusable password, the SSH server verifies that the connecting client possesses the private key that matches a public key stored for the account. The private key is never transmitted across the network.

**Configuration**

```text
PubkeyAuthentication yes
```

**Local verification**

```bash
sshd -T | grep pubkeyauthentication
```

Expected effective value:

```text
pubkeyauthentication yes
```

A successful SSH login using the configured key should also be tested before closing the existing administrative session.

### LogLevel VERBOSE

**Why it matters**

`LogLevel VERBOSE` increases SSH logging detail and provides better visibility into remote-access activity. The additional authentication detail is useful for troubleshooting, auditing, and incident review.

**Configuration**

```text
LogLevel VERBOSE
```

**Local verification**

```bash
sshd -T | grep loglevel
```

Expected effective value:

```text
loglevel VERBOSE
```

After a test login, SSH authentication events should be reviewed in the system journal or authentication logs to confirm that the expected detail is being recorded.

### PermitRootLogin no

**Why it matters**

`PermitRootLogin no` prevents direct SSH login as `root`. Administrators must instead authenticate with a named account and elevate privileges with `sudo`. This improves accountability and reduces direct remote exposure of the highest-privileged account.

**Configuration**

```text
PermitRootLogin no
```

**Local verification**

```bash
sshd -T | grep permitrootlogin
```

Expected effective value:

```text
permitrootlogin no
```

A separate privileged user should be confirmed to have working `sudo` access before the active root-capable session is closed.

## Validation Workflow

For each SSH control:

1. Inspect the active configuration and included files.
2. Make the change in the appropriate SSH configuration file or drop-in.
3. Validate syntax before reload.
4. Check the effective value with `sshd -T`.
5. Test a separate SSH session so recovery access is preserved.
6. Review relevant SSH logs where applicable.
7. Re-run the OpenSCAP scan and attach the individual PASS/FAIL result before marking the control verified.

Exact rule IDs and severities have not been supplied. Track final scan results in the [findings tracker](../tracking/findings.md) using the [methodology](../documentation/methodology.md).

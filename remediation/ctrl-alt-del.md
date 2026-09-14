# Ctrl+Alt+Del Hardening

## Finding

The work addressed **Disable Ctrl-Alt-Del Burst Action** and **Disable Ctrl-Alt-Del Reboot Activation**. Both are **VERIFIED** based on the later OpenSCAP PASS observations supplied in the lab notes. Exact rule IDs, severity, and the associated report date were not supplied.

## Why This Matters

An accidental or unauthorized console key sequence should not reboot the VM. systemd handles normal Ctrl+Alt+Del activation and rapid repeated keypresses separately, so masking the target alone does not describe the whole change. `CtrlAltDelBurstAction=none` addresses the burst behavior; masking the target addresses normal reboot activation.

## Initial State

The original configuration text and terminal output were not retained in the supplied record. I will not invent an initial value or screenshot. During this work, my normal user could not write to `/etc/systemd/system.conf`. I later created duplicate `CtrlAltDelBurstAction=none` entries while testing.

## Investigation

I needed to distinguish the manager's burst setting from the reboot target, and check the actual file rather than assume a script had changed it. I used grep and sed concepts while inspecting and cleaning up entries. The exact historical grep/sed commands were not supplied.

This is a **repeatable inspection example**, not captured lab output:

```bash
grep -nE '^[[:space:]]*#?[[:space:]]*CtrlAltDelBurstAction[[:space:]]*=' /etc/systemd/system.conf
```

`grep` finds matching lines, `-n` includes their line numbers, and `-E` enables extended regular expressions. `^` anchors the match to the start of the line, `[[:space:]]*` permits whitespace, and `#?` includes an optional comment marker. The last `=` identifies an assignment. Single quotes keep the shell from interpreting the pattern. Including commented lines helps distinguish examples from active settings; a match alone does not establish the effective value. No output is fabricated here.

## Remediation

The final configuration included the following assignment in the `[Manager]` section of `/etc/systemd/system.conf`:

```ini
CtrlAltDelBurstAction=none
```

`none` tells systemd not to take a burst action. The other confirmed command was:

```bash
sudo systemctl mask ctrl-alt-del.target
```

I also corrected the permission problem by running the remediation script with sudo. Its filename and source were not supplied, so this page does not invent an invocation or distribute a replacement script.

The record does not say whether a manager re-execution or reboot was used to activate the configuration. For a future reproduction, distinguish saved configuration from running behavior and follow the installed systemd documentation for applying manager settings. Unit-file reload alone should not be assumed to prove this manager setting is active. No reboot or destructive keypress test was performed as part of this repository update.

## Command Breakdown

| Part | Meaning in this change |
| --- | --- |
| `sudo` | Runs the following command with elevated privileges, normally root |
| `systemctl` | Manages systemd services and other units |
| `mask` | Prevents a unit from starting by linking its unit-file name to `/dev/null` |
| `ctrl-alt-del.target` | The target associated with the normal Ctrl+Alt+Del reboot action |

Masking is stronger than disabling: disabling removes enablement links but does not generally prevent other activation. This command needs privileges because it changes system unit configuration.

## Troubleshooting

### Permission errors

I first ran the remediation script as my normal user. It tried to modify the root-owned `/etc/systemd/system.conf` and failed with permission errors. Running the script with sudo gave it permission to modify the file. I did not need to make the system configuration writable by everyone.

That distinction also matters with shell redirection. `>` replaces a file's contents and `>>` appends; the invoking shell opens the destination. Elevating a command with sudo does not automatically elevate a separate shell's redirection. Repeated appending can also create duplicate assignments.

### Duplicate configuration entries

During testing I accidentally created duplicate `CtrlAltDelBurstAction=none` entries. I used grep and sed concepts to understand inspection and cleanup. The supplied history does not retain the exact cleanup command or final line count, so I cannot claim a specific command removed a specific number of duplicates.

For learning, this **read-only sed example** displays active assignments:

```bash
sed -n '/^[[:space:]]*CtrlAltDelBurstAction[[:space:]]*=/p' /etc/systemd/system.conf
```

`sed` is a stream editor. `-n` suppresses its usual automatic output; `/pattern/` selects matching lines and `p` prints them. This command does not edit the file. In a substitution expression, `s/pattern/replacement/` replaces a match; `-i` would edit in place. A substitution on every matching line would still leave duplicate lines, so it is not a complete duplicate-removal strategy. Inspect surrounding sections and any overrides before making a narrowly scoped edit, and retain a recoverable copy first.

## Verification

These are **suggested follow-up checks**, not historical output:

```bash
systemctl is-enabled ctrl-alt-del.target
systemd-analyze cat-config systemd/system.conf
```

`systemctl is-enabled` reports the unit's enablement state. The expected state for this target is `masked`; it may return a nonzero exit status for that state, so read the output rather than treating any nonzero result as a failed remediation. `systemd-analyze cat-config` displays configuration files and drop-ins for the named configuration, including their source locations. Review active assignments and precedence; merely finding the desired text is insufficient. It shows configuration on disk, not proof that the running manager has adopted it.

For stronger evidence, capture reviewed output, establish how the setting was activated, and run the [scan script](../scripts/README.md) again. Do not repeatedly press Ctrl+Alt+Del on a VM without a recovery plan just to test this page.

## OpenSCAP Result

| Control | Reported later result | Tracker status |
| --- | --- | --- |
| Disable Ctrl-Alt-Del Burst Action | PASS | VERIFIED |
| Disable Ctrl-Alt-Del Reboot Activation | PASS | VERIFIED |
| Verify that Interactive Boot is Disabled | PASS | VERIFIED |
| Require Authentication for Single User Mode | PASS | VERIFIED |

These are lab-owner-provided results from a later scan; the raw report and exact milestone are not available in this repository. The related boot controls were reported passing, but their remediation steps were not provided and their results are not attributed to the Ctrl+Alt+Del change. The [overall scan progression](../scans/progress/README.md) is recorded separately.

## What I Learned

The permission failure made normal-user versus root access concrete. The duplicate entries taught me to inspect the file instead of repeatedly appending a desired setting. I also learned that two controls can address different ways of triggering the same reboot outcome. The later OpenSCAP PASS results mattered more than a script printing that it had finished.

Technical reference: [systemd manager configuration](https://www.freedesktop.org/software/systemd/man/systemd-system.conf.html) and [systemctl](https://www.freedesktop.org/software/systemd/man/systemctl.html). These explain command behavior; the lab observations above come from my supplied notes.

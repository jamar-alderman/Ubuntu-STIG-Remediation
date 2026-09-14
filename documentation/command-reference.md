# Command Reference

This covers commands in the supplied scan script, confirmed Ctrl+Alt+Del work, and explicitly labeled inspection examples. It is not a claim that every example below was executed on the VM.

| Command | Project use | Explanation / source |
| --- | --- | --- |
| `bash` | Launch the scan script | Shell interpreter; takes the script path as an argument. [Usage](../scripts/README.md) |
| `sudo` | Run OpenSCAP and modify root-owned system configuration | Elevates the following command, normally to root; does not elevate a separate shell's redirection. [Permission failure](../remediation/ctrl-alt-del.md#troubleshooting) |
| `systemctl` | Mask `ctrl-alt-del.target`; suggested state inspection | Manages systemd units. `mask` blocks activation; `is-enabled` displays enablement state. [Breakdown](../remediation/ctrl-alt-del.md#command-breakdown) |
| `systemd-analyze` | Suggested follow-up configuration inspection | `cat-config` shows the named configuration and drop-ins on disk. [Verification limits](../remediation/ctrl-alt-del.md#verification) |
| `grep` | Locate burst-action assignments | Prints matching lines; the documented `-nE` example adds line numbers and extended patterns. [Pattern explanation](../remediation/ctrl-alt-del.md#investigation) |
| `sed` | Understand configuration inspection and cleanup | A stream editor; the documented `-n` and `p` example prints selected lines without editing. Substitution and in-place editing are explained, not claimed as captured commands. [Duplicate entries](../remediation/ctrl-alt-del.md#duplicate-configuration-entries) |
| `date` | Timestamp scan filenames | Produces formatted local date/time. [Format tokens](../scripts/README.md#script-breakdown) |
| `echo` | Print progress and the report URL | Writes messages or a blank line. [Script](../scripts/STIGscan.sh) |
| `oscap` | Evaluate the OpenSCAP XCCDF profile | `xccdf eval` reads the datastream and writes XML/HTML outputs using the selected profile. [Options](../scripts/README.md#script-breakdown) |
| `cd` | Select the temporary server's working directory | Changes the shell's working directory. [Exposure and guard](../scripts/README.md#changes-from-the-supplied-version) |
| `hostname` | Populate the displayed VM address | `-I` lists addresses; the first is not necessarily reachable from the viewing machine. [Limits](../scripts/README.md#troubleshooting-and-limits) |
| `awk` | Select an address from the pipeline | `{print $1}` prints the first whitespace-separated field. [Quoting and pipe](../scripts/README.md#script-breakdown) |
| `python3 -m http.server` | Temporary report viewing | `-m` runs the module; port 8000 is the script's argument. [Exposure warning](../scripts/README.md#before-running) |
| `exit` | Stop after scan or directory errors | Shell builtin that terminates the script with the supplied exit code. [Guard syntax](../scripts/README.md#changes-from-the-supplied-version) |

## Shell Concepts That Came Up

Variables store values; `$NAME` expands them. `$(...)` captures command output. Double quotes preserve expanded arguments; single quotes keep grep/sed patterns and awk's field expression literal to the shell. A backslash immediately before a newline continues one command across lines. A pipe sends standard output into another command's standard input. These appear in the [scan script explanation](../scripts/README.md).

`>` replaces file contents, `>>` appends, and `>&2` directs output to standard error. Shell redirection happens with the shell's privileges. File ownership and permission bits determine who can read, write, or execute a file; modifying a root-owned system file normally requires elevated access. Those concepts explain the [Ctrl+Alt+Del permission failure and duplicates](../remediation/ctrl-alt-del.md#troubleshooting).

Commands such as `firewall-cmd`, `dnf`, `ip`, `ss`, `journalctl`, `chmod`, `chown`, `ls`, `cp`, `mv`, `rm`, `cat`, `nano`, `find`, and `auditctl` were listed as possible reference entries in the project specification, but their actual lab invocations or context were not supplied. They will be added with real examples when those work groups are documented. A mention of chmod/chown auditing is a finding category, not proof those commands were used for remediation.

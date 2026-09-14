# OpenSCAP Scan Script

[STIGscan.sh](STIGscan.sh) is my reusable evaluation workflow for the Rocky VM. It evaluates the selected profile; it does not apply remediation. The repository version is based on the script supplied with my lab notes. It has not been run against `nyx0100` during this documentation update.

## Before Running

Use the Rocky lab VM with Bash, sudo access, OpenSCAP, the specified datastream, Python 3, `date`, `hostname`, and `awk` available. Their installation is not performed by this script. Run it as your normal user so `$HOME` selects your home directory; the script elevates only the scanner. Running the whole script under sudo can change `$HOME` and also run the HTTP server as root.

**The retained HTTP behavior exposes files under the entire home directory, not just the report.** It has no authentication or encryption and listens on all interfaces by default. Reachable clients can request readable files, including hidden paths they know and files reached through symlinks. Use this behavior only on an isolated trusted lab network after inspecting the directory. It is not a reviewed or approved accepted-risk decision for the VM. If that exposure is unsuitable, run only the documented evaluation command and view the report locally instead of starting this script's server. A future improvement could serve a dedicated report directory; the current home-directory behavior is retained to keep the supplied script recognizable. Python documents the serving behavior and limitations in its [HTTP server reference](https://docs.python.org/3/library/http.server.html).

From the repository root on the lab VM:

```bash
bash scripts/STIGscan.sh
```

`bash` runs the named shell script; `scripts/STIGscan.sh` is its path relative to the repository root. The call does not require an executable bit because Bash reads the file directly.

## Workflow

1. Select the profile and Rocky datastream.
2. Create a timestamp for filenames.
3. Run the OpenSCAP evaluation with elevated access.
4. Save XML results.
5. Generate an HTML report.
6. Determine the first address reported for the VM.
7. Start a temporary HTTP server on port 8000.
8. Print a URL for viewing the report from another machine that can reach the VM.

Stop the server with **Ctrl+C** in the terminal that runs it. The server stays in the foreground until stopped. Firewall and VM networking must already permit the connection; the script does not change either.

## Script Breakdown

| Expression | What it does and why it is here |
| --- | --- |
| `#!/bin/bash` | Shebang: selects Bash when the executable file is invoked directly |
| `PROFILE="..."` | Assigns the exact OpenSCAP profile identifier; shell assignments have no spaces around `=` |
| `DATASTREAM="..."` | Stores the installed Rocky content path, even though the benchmark is identified as RHEL 10 |
| `DATE=$(...)` | Captures the output of the command inside `$(...)` into the `DATE` variable; this is command substitution |
| `date +"%Y-%m-%d_%H-%M-%S"` | Formats local time as year-month-day_hour-minute-second: `%Y` year, `%m` month, `%d` day, `%H` 24-hour clock hour, `%M` minute, `%S` second; `+` introduces the format |
| `"$PROFILE"`, `"$DATASTREAM"`, `"$DATE"` | Expand variables; double quotes preserve each expanded argument even if it contains spaces |
| `$HOME` | The invoking shell's home-directory value; used for both output paths and the served directory |
| `echo` | Prints progress and paths; an `echo` with no arguments prints a blank line |
| `sudo oscap xccdf eval` | Runs the OpenSCAP XCCDF evaluation as root so checks can inspect protected configuration |
| `--profile` | Chooses the profile from the datastream |
| `--results` | Writes XCCDF XML results to the timestamped output path |
| `--report` | Writes the human-readable HTML report |
| Final `"$DATASTREAM"` argument | Supplies the input content to evaluate |
| Trailing backslash | Continues the same shell command on the next line; it must be immediately followed by the newline, without trailing spaces |
| `cd "$HOME"` | Changes the working directory to the home directory before starting the HTTP server |
| `hostname -I` | Lists configured host addresses; uppercase `-I` can return multiple addresses |
| Pipe between `hostname` and `awk` | Passes the first command's standard output to the second command's standard input |
| `awk '{print $1}'` | Prints the first whitespace-separated field of each input line; single quotes protect awk's `$1` from shell expansion |
| `IP=$(...)` | Stores the output of that pipeline for the displayed URL |
| `python3 -m http.server 8000` | Runs Python's `http.server` module on TCP port 8000, serving the working directory |

## Evaluation Without the Server

The evaluation block below repeats the same profile, timestamp, and output options without launching HTTP. The assignments, command substitution, options, quoting, and line continuations are explained above.

```bash
PROFILE="xccdf_org.ssgproject.content_profile_stig"
DATASTREAM="/usr/share/xml/scap/ssg/content/ssg-rl10-ds.xml"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
sudo oscap xccdf eval \
  --profile "$PROFILE" \
  --results "$HOME/results-$DATE.xml" \
  --report "$HOME/report-$DATE.html" \
  "$DATASTREAM"
```

Open the resulting HTML file in a local browser or transfer it privately using your established lab workflow. Review it before any publication.

## Changes from the Supplied Version

The profile, datastream, timestamp format, home-directory filenames, evaluation arguments, IP pipeline, port, and HTTP command are retained. The original was supplied in the project specification; there was no existing repository script to overwrite.

- Replaced the original DISA scan banner with “RHEL 10 OpenSCAP STIG-aligned” to match the benchmark caveat.
- Captured OpenSCAP's exit status immediately. Exit 0 permits continuing; exit 2 also permits continuing because it can mean fail or unknown rule results. Other statuses stop the script before serving files.
- Checked that both output files exist and are nonempty before announcing a completed evaluation. This is not validation of report contents.
- Added a guard so failure to change to the home directory stops execution instead of serving an unintended working directory.
- Added a visible warning about the retained home-directory server exposure and how to stop it.

`SCAN_STATUS=$?` saves the previous command's exit code. Bash `[[ ... ]]` evaluates a condition; `-ne` means numeric “not equal,” `&&` requires both conditions, `||` means either condition, `!` negates a test, and `-s` checks that a file exists and has nonzero size. `if`, `then`, and `fi` delimit a conditional block. `exit` stops the script with the supplied status. In `cd ... || exit 1`, `||` runs the second command only if the first fails. `>&2` redirects a message to standard error rather than standard output.

OpenSCAP documents evaluation return codes in its [manual source](https://github.com/OpenSCAP/openscap/blob/main/utils/oscap.8). Exit 2 is not a passing scan. Once the server runs, the script's eventual exit status comes from Python rather than the earlier evaluation; the scanner status is printed separately. No automatic compliance decision should rely on the wrapper's final exit code.

## Troubleshooting and Limits

A missing datastream, failed sudo authorization, or scanner error should stop this version before server startup. An error after a partial report does not turn that report into a verified scan. The file check also stops startup if outputs are absent or empty.

The first address from `hostname -I` is only a convenience: it may be the wrong interface for your other machine, may be absent, or may be IPv6 (which needs brackets in a browser URL). Check the actual reachable VM address. Port 8000 may already be occupied; do not assume a failed server launch means the scan failed. File ownership and permissions may also prevent the unprivileged server from reading scanner output. Do not broadly loosen home-directory permissions to fix access.

Filenames have one-second resolution. Avoid simultaneous runs in the same home directory because they can collide. No dependency installer, automatic firewall opening, HTML/XML publication, or remediation behavior was added.

See [scan evidence review](../scans/README.md) before sharing reports and the [command reference](../documentation/command-reference.md) for the other commands used in this lab.

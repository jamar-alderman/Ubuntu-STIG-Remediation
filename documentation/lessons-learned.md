# Lessons Learned

## A script has the privileges of the user running it

During the Ctrl+Alt+Del work, I ran a remediation script as my normal user. It tried to change `/etc/systemd/system.conf` and failed with permission errors. Running the script with sudo gave it the privileges needed to modify the root-owned file. I learned to inspect what a script will change before giving the whole script elevated privileges.

`sudo` changes the privileges of the command it runs. It does not make every part of a shell expression privileged. In particular, redirection is performed by the invoking shell; putting sudo before a command does not automatically give that shell permission to write a protected file.

## Masking is different from disabling

For `ctrl-alt-del.target`, I used `systemctl mask`. Disabling a unit removes enablement links, but it does not generally prevent manual or dependency-driven activation. Masking links the unit to `/dev/null` to prevent it from being started. That difference mattered for the reboot target.

## Repeated appends can leave duplicates

While testing, I created duplicate `CtrlAltDelBurstAction=none` entries. Seeing the desired text once was not enough; I needed to inspect the other occurrences and the surrounding configuration too. `grep` helped locate entries, and `sed` helped me understand how matching lines can be changed. The exact cleanup command was not retained, so the remediation page labels its inspection examples rather than presenting a recreated terminal transcript.

## Local checks and OpenSCAP answer different questions

A file can contain the intended text without proving the running service uses it. Local verification helps check configuration and behavior; OpenSCAP checks the benchmark's interpretation. The later PASS observations for both Ctrl+Alt+Del controls were useful confirmation after the manual work. I still need to add reviewed evidence artifacts to the repository.

## A failed check needs a decision

The baseline had 278 failures, including large audit and account-security groups. Working through smaller groups helped me learn the workflow. Separate filesystems require storage planning, while Rocky Linux certification limits cannot be solved by pretending it is RHEL. I need to understand the requirement before deciding whether to change the system, plan architectural work, or document a limitation.

See [Ctrl+Alt+Del troubleshooting](../remediation/ctrl-alt-del.md) and the [findings tracker](../tracking/findings.md).

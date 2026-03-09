# Notes
- use `sudo unshare -n sh X.SlackBuild` to test.
- Match with PPA "jammy"
- Note that for `plaso` - `python3 run_test.py` to work you need mock
- The mock SB says it's for py2, but will build for 3 as well (py3-pbr is already
  in Slackware).
- also might need "fakeredis" from pip3
- run `check_dependencies.py` with `python3 utils/check_dependencies.py` from root of source.
- Content disposition on GitHub:
    - https://github.com/DEVELOPER/PRGNAM/archive/refs/tags/vVERSION/PRGNAM-VERSION.tar.gz
    - if that does not work, remove the "v" from the version number and
      try again.
- ssh into the VM using "-Y" and X-forwarding so firefox can be used.
    - This works well in -current with Hypr/Wayland.
    - Set FF to use vimium and bookmarks.
    - Change "downloads" dir to the local working repo.
    - add "Gruvbox Material Soft Theme"
- in the `./CheckConflict.sh`, use `gx` on the home page URL to pull up FF
  and download the source tar.gz.
- in the `LibyalSource.sh`, use `ssh-agent` and `ssh-add` to make the
  scp/ssh calls non-interactive.
- alias `ionosls` calls `ssh -t ionos "cd linuxleocom/Source && ls"` to
  see if current source is uploaded. 
- Use `sshfs` to mount the project dir on the build box and download
    source directly to it...can't seem to get browsers working of x
    forwarding without crashing qemu.
    ```
    mkdir sshfsdir
    sshfs qemu:Projects/slackbuilds-bgrundy sshfsdir/
    ```
    - this may not be needed with ssh forwarding an FF running good on
        Wayland.



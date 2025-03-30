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
    # on the host box:
    mkdir sshfsdir
    sshfs qemu:Projects/slackbuilds-bgrundy sshfsdir/
    ```
## Workflow

- Open an sshfs mount from the host to the project dir on devel box (as
    above).
- Create (if not already) a `UpdatesReady` directory to move completed Builds
    into - ready for submission.
- run `ssh-agent` to make scripts non-interactive:
    - `exec ssh-agent bash`
    - `ssh-add ~/.ssh/id_rsa`
    - `ssh-add -l`
1) Run `CheckConflict.sh` on the target directory
2) Open and edit the `.info` file for version/download/MD5
3) Run `Md5DL.sh` do download the source and hash it.
4) Extract source and check for Document/requirement changes, etc.
5) Remove the extracted source dir
6) Run `LibyalSolurce.sh` on the source tarball to move it to Ionos.
7) Run `Build.sh` on the target directory to build the package and lint.
8) Move the completed build to `UpdatesReady`


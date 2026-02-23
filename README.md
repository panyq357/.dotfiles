Run `setup.bash` in new machine.

All dotfiles are packed in modules.

In each module, there are three type of scripts:

- `install.*sh`: run this when need to install
- `load.*sh`: need to be load when start a new shell (e.g. setup `PATH`)
- `link.*sh`: need to be run only once (e.g. link config files/dirs)


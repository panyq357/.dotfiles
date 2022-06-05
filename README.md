# Dotfile Backup

A dumb way to backup dotfiles.

## Usage

### Recover

First, use git to clone this repository to home directory.

Then, source some functions.

```zsh
source ~/.dotfiles/source_me.sh
```

Finally, run this command.

```zsh
dotfiles recover
```

All dotfiles will be copied from `~/.dotfiles` to home directory.


### Backup

First, add dotfile name to `~/.dotfiles/dotfile_list.sh`.

Then, source some functions.

```zsh
source ~/.dotfiles/source_me.sh
```

Finally, run this command.

```zsh
dotfiles backup
```

All dotfiles will be copied from home directory to `~/.dotfiles`.


### Upload

First, source some functions.

```zsh
source ~/.dotfiles/source_me.sh
```

Then, run this command.

```zsh
dotfiles upload "commit message"
```

All dotfiles in `~/.dotfiles` will be committed and pushed to this repository.

### Sync to remote server

First, backup dotfiles.

Then, source some functions.

```zsh
source ~/.dotfiles/source_me.sh
```

Finnaly, run this command.

```zsh
dotfiles remote_sync MY_REMOTE_IP
```

All dotfiles will be copied from `~/.dotfiles` to remote server home directory.


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


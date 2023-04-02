#!/usr/bin/env python3

from platform import platform
from pathlib import Path

symlinks = {
    "Unix": {
        "vimrc": "~/.vimrc",
        "nvim": "~/.config/nvim",
        "tmux.conf": "~/.tmux.conf",
        "condarc": "~/.condarc",
        "Rprofile": "~/.Rprofile",
        "gitconfig": "~/.gitconfig"
    },
    "macOS": {
        "zshrc": "~/.zshrc"
    },
    "Linux": {
        "bashrc": "~/.bashrc"
    }
}

dot_dotfiles = Path(__file__).parent


def main() -> None:
    if "macOS" in platform():
        for file, link in symlinks["Unix"].items():
            create_symlink(file, link)
        for file, link in symlinks["macOS"].items():
            create_symlink(file, link)
    if "Linux" in platform():
        for file, link in symlinks["Unix"].items():
            create_symlink(file, link)
        for file, link in symlinks["Linux"].items():
            create_symlink(file, link)


def create_symlink(file: 'str', link: 'str') -> None:
    file = dot_dotfiles / file
    link = Path(link).expanduser()
    if link.is_dir() or link.is_file():
        print(f"{link} exists, skipped.")
    else:
        if link.parent.exists():
            link.symlink_to(file)
        else:
            link.parent.mkdir(parents=True)
            link.symlink_to(file)
        print(f"{file} -> {link}")


if __name__ == "__main__":
    main()

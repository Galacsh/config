#!/usr/bin/env bash

config_dir=${HOME}/.config
repository="https://github.com/Galacsh/config.git"
branch="main"
vim_dir=${HOME}/.vim
aliases_file=${HOME}/.aliases

# 1. Create "$HOME/.config" if doesn't exist:
if [[ ! -d "${config_dir}" ]]; then
  mkdir "${config_dir}"
fi

# 2. Change directory to `.config`.
cd "${config_dir}"

# 3. Clean up
rm -rf .git .gitignore README.md alacritty ideavim install.sh nvim vim

# 4. Load files with git.
git init
git remote add origin "${repository}"
git fetch
git reset "origin/${branch}"
git restore .

# 5. Create link(symbolic) of `vim` directory at `${HOME}/.vim`.
rm -rf "${vim_dir}"
ln -s "${config_dir}/vim" "${vim_dir}"

# 6. Download alacritty theme.
./alacritty/init.sh

# 7. Download tmux theme.
./tmux/init.sh

# 8. Create link(symbolic) of `aliases.sh` file at `${HOME}/.aliases`.
rm "${aliases_file}"
ln -s "${config_dir}/aliases.sh" "${aliases_file}"


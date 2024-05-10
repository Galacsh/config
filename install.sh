#!/usr/bin/env bash

config_dir=${HOME}/.config
repository="https://github.com/Galacsh/config.git"
branch="main"
vim_dir=${HOME}/.vim

# 1. Create "$HOME/.config" if doesn't exist:
if [[ ! -d "${config_dir}" ]]
  mkdir "${config_dir}"
fi

# 2. Change directory to `.config`.
cd "${config_dir}"

# 3. Load files with git.
git init
git remote add origin "${repository}"
git fetch
git reset --mixed "origin/${branch}"

# 4. Link(symbolic) `vim` directory to `${HOME}/.vim`.
rm -rf "${vim_dir}"
ln -s "${config_dir}/vim" "${vim_dir}"


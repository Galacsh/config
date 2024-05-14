# Configuration Files

Files in this repository are my configuration files.

To install:

```shell
curl -sSf https://raw.githubusercontent.com/Galacsh/config/main/install.sh | bash -s
```

## What does install.sh do?

1. Create "$HOME/.config" if doesn't exist:

```shell
if [[ ! -d "${HOME}/.config" ]]
  mkdir "${HOME}/.config"
fi
```

2. Change directory to `.config`.

```shell
cd "${HOME}/.config"
```

3. Clean up

```shell
rm -rf .git .gitignore README.md alacritty ideavim install.sh nvim vim
```

4. Load files with git.

```shell
git init
git remote add origin "${repository}"
git fetch
git reset "origin/${branch}"
git restore .
```

5. Create link(symbolic) of `vim` directory at `${HOME}/.vim`.

```shell
rm -rf "${HOME}/.vim"
ln -s "${HOME}/.config/vim" "${HOME}/.vim"
```

6. Download alacritty theme.

```shell
./alacritty/init.sh
```

7. Download tmux theme.

```shell
./tmux/init.sh
```

8. Create link(symbolic) of `aliases.sh` file at `${HOME}/.aliases`.

```shell
rm "${aliases_file}"
ln -s "${config_dir}/aliases.sh" "${aliases_file}"
```

> [!IMPORTANT]
> To use SSH:  
> `git remote set-url origin "git@github.com:Galacsh/config.git"`


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
git remote add origin https://github.com/Galacsh/config.git
git fetch
git reset --mixed origin/main
```

5. Link(symbolic) `vim` directory to `${HOME}/.vim`.

```shell
rm -rf "${HOME}/.vim"
ln -s "${HOME}/.config/vim" "${HOME}/.vim"
```

6. Download alacritty theme.

```shell
./alacritty/init.sh
```

> [!IMPORTANT]
> To use SSH:  
> `git remote set-url origin "git@github.com:Galacsh/config.git"`


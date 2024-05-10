# Configuration Files

Files in this repository are my configuration files.

To install:

```shell
curl -sSf https://raw.githubusercontent.com/Galacsh/config/main/install.sh | sh
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

3. Load files with git.

```shell
git init
git remote add origin https://github.com/Galacsh/config.git
git fetch
git reset --mixed origin/main
```

4. Link(symbolic) `vim` directory to `${HOME}/.vim`.

```shell
rm -rf "${HOME}/.vim"
ln -s "${HOME}/.config/vim" "${HOME}/.vim"
```

> [!IMPORTANT]
> To use SSH:  
> `git remote set-url origin "git@github.com:Galacsh/config.git"`


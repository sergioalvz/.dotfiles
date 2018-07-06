# .dotfiles

This is my personal setup for macOS. It is quite opinionated, so I would not expect it to perfectly match your preferences.

Please, feel free to download this code and customize whatever you need to make it work for you :relaxed:

## Usage

### Download

In case you cannot use `git` to download this repository, use the following `curl` command (which is generally available on a macOS fresh install) to download the project in the current directory:

```
curl -sL https://github.com/sergioalvz/.dotfiles/archive/master.tar.gz | tar xz
```

### Install

Use `make` to run some predefined tasks:

* `make all` installs the whole tooling suite as well as the dotfiles
* `make tools` installs only the tooling suite ([brew](https://brew.sh), [nvm](https://github.com/creationix/nvm), [zsh](https://en.wikipedia.org/wiki/Z_shell))
* `make dotfiles` installs only the dotfiles (by using symlinks)

## Credits

This repo has been _heavily_ inspired one way or another by:

* **[@dgsuarez](https://github.com/dgsuarez/.dotfiles)**
* **[@jessfraz](https://github.com/jessfraz/dotfiles)**
* **[@sjl](https://bitbucket.org/sjl/dotfiles)**
* **[@holman](https://github.com/holman/dotfiles)**

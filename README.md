# .dotfiles

My personal macOS setup. Opinionated; download and tweak to taste.

## What's inside

| File                                         | Purpose                                                                                                                                  |
| -------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| [Brewfile](Brewfile)                         | Homebrew formulae + casks (CLI tools, fonts, GUI apps)                                                                                   |
| [install.sh](install.sh)                     | Idempotent bootstrap: Xcode CLT → Homebrew → zsh + oh-my-zsh plugins → symlinks → optional macOS defaults                                |
| [zsh/zshrc](zsh/zshrc)                       | Shell: oh-my-zsh + **starship** prompt, **mise** runtime manager, **zoxide**, **fzf** keybindings, 1Password SSH agent                   |
| [git/gitconfig](git/gitconfig)               | Modern git defaults (delta pager, `pull.rebase`, `rerere`, `branch.sort`, `push.autoSetupRemote`) + SSH commit/tag signing via 1Password |
| [git/gitignore_global](git/gitignore_global) | macOS / editor / AI-assistant junk                                                                                                       |
| [ssh/config](ssh/config)                     | Routes all SSH auth through the 1Password SSH agent                                                                                      |
| [vscode/settings.json](vscode/settings.json) | Editor + Copilot/Chat configuration                                                                                                      |
| [macos/defaults.sh](macos/defaults.sh)       | Optional `defaults write` tweaks (fast key repeat, Finder, Dock, screenshots)                                                            |

## Usage

```sh
git clone https://github.com/sergioalvz/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

No `git`? Use `curl`:

```sh
curl -sL https://github.com/sergioalvz/.dotfiles/archive/trunk.tar.gz | tar xz
```

## Post-install

1. `exec zsh` to reload the shell.
2. `gh auth login` to authenticate the GitHub CLI. The standalone **copilot-cli** (`copilot`) ships via Homebrew and uses the same Copilot entitlement.
3. Sign in to **1Password** and enable the SSH agent: **Settings → Developer → Use the SSH agent**. Your SSH key syncs from the vault — no key files needed on disk. Commit signing is already wired up in [git/gitconfig](git/gitconfig); the first commit on a new machine will prompt for Touch ID.
4. Set per-repo git identity (kept out of the global config on purpose):
   ```sh
   git config user.name  "Sergio Álvarez"
   git config user.email "you@example.com"
   ```
   Or use `includeIf` blocks in `~/.gitconfig` for work-vs-personal directories.
5. Install runtimes with **mise** (reads `.nvmrc`, `.ruby-version`, `.tool-versions`):
   ```sh
   mise use --global node@lts python@3.13 ruby@3.3
   ```

## Credits

Heavily inspired by **[@dgsuarez](https://github.com/dgsuarez/.dotfiles)**, **[@jessfraz](https://github.com/jessfraz/dotfiles)**, **[@sjl](https://bitbucket.org/sjl/dotfiles)**, and **[@holman](https://github.com/holman/dotfiles)**.

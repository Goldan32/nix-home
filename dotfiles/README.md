# Dotfiles

To create symlinks sensibly, use

```bash
stow --no-folding .
```

Install cargo and bat, activate bat theme

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install bat
bat cache --build
```

Install neovim using `bob` (must use `bob`, `nvim`, executable points to it in `.zshrc`)

```bash
cargo install bob-nvim && \
bob install nightly && \
bob use nightly
```

Fully functional neovim:

- Install `node`: https://nodejs.org/en/download/package-manager
- Install `pnpm`: https://pnpm.io/installation
- `npm i -g bash-language-server`
- `npm i -g markdownlint-cli`
- `npm i -g typescript typescript-language-server`
- `npm i -g prettier`
- `npm i -g svelte`
- `pnpm i -g pyright`
- `sudo apt install -y unzip`
- `cargo install stylua`
- `sudo apt install -y shellcheck`


Hyprland checklist:

- [x] Sound/volume settings: `pavucontrol`
- [x] Bluetooth headset: `bluetoothctl` for connecting a bluetooth device
- [x] Screen sharing: Works if installed via script
- [x] Checking battery percantage: `acpi`
- [x] Set volume from command line: `wpctl`
- [ ] Wifi connection script with `nmcli`
  - Set of aliases/scripts (`wifi` command)
- [ ] Screen locking
- [x] Faster key inputs on holding a key
- [x] Power saving modes: `powerprofilesctl`
- [x] Full custom keybinds
- [ ] Per-system configs
- [ ] Function keys
- [ ] Unify [fresh-install](https://github.com/Goldan32/fresh-install) and this repo
  - Move this repo to a subdir of `fresh-install`
  - Preserve history for this repo
  - Archive `fresh install`
  - Create script for correct `stow` usage
    - Should also link scripts to a path dir
    - use set -e (or something to stop exec on error)
- [ ] Create full install script
  - Apt packages
  - Roboto mono
  - Wezterm
  - Firefox
  - Rust/Cargo
  - Neovim via bob
  - bat
  - nodejs via nvm
  - Neovim lsp-s see above
- [ ] Fingerprint sensor

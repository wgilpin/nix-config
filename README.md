## Nix build for Mac

### Pre-nix

1. Open System Settings > Privacy & Security > Full Disk Access.

2. Find Terminal (or Ghostty if you're using it) and toggle it ON.

3. If it asks to "Quit & Reopen," do it.

### Nix Install

1. Install Nix (Determinate)
curl --proto '=https' --tlsv1.2 -sSf -L <https://install.determinate.systems/nix> | sh -s -- install

2. Source Nix immediately so the next commands work
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

3. Install Homebrew
/bin/bash -c "$(curl -fsSL <https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh>)"

4. Add Homebrew to PATH (Required for M4 Macs)
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

5. Run the Nix-Darwin switch
sudo nix run nix-darwin -- switch --flake ~/.config/nix-config#MIND-26

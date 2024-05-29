# Magicmonty's WSL HomeManager config

## Bootstrap 

- Install Alpine Linux WSL from Microsoft store
- Bootstrap Nix:
  
  ```bash
  # Change user to root and install sudo, curl and xz
  su -
  apk add --no-cache sudo curl xz
  echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel
  
  # Add user to wheel group
  adduser <USERNAME> wheel

  # Set password for user
  passwd <USERNAME>
  
  # Exit to normal user
  exit

  curl -L https://nixos.org/nix/install | sh
  echo ". /home/<USERNAME>/.nix-profile/etc/profile.d/nix.sh" >> ~/.profile
  ```

- Clone config to `~/.config/home-manager` and bootstrap home-manager

  ```bash
  # Open a shell with git, home-manager and openssh
  nix-shell -p git -p home-manager
  
  # Set experimental options for nix
  mkdir -p ~/.config/nix
  echo "extra-experimental-features = nix-command flakes" > ~/.config/nix/nix.conf

  # Clone config
  git clone https://github.com/magicmonty/dotfiles-wsl.git ~/.config/home-manager

  # Initial switch (replaces manually generated nix.conf)
  home-manager switch -b backup
  rm ~/.config/nix/nix.conf.backup
  ```

## General usage
- after changing something, a `home-manager switch` should suffice
- update the config with `nix flake update` in the `~/.config/home-manager/` directory

{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.mgnix.apps.neovim = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
    lite = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = let
    inherit (config.mgnix.apps.neovim) enable lite;
  in
    mkIf enable {
      home.packages = [
        (
          if lite
          then pkgs.neovim-lite
          else pkgs.neovim
        )
      ];

      home.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };

      programs.zsh = mkIf config.mgnix.apps.zsh.enable {
        shellAliases = {
          v = "nvim";
          vi = "nvim";
          vim = "nvim";
          vimdiff = "nvim -d";
        };
      };
    };
}

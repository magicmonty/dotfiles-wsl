{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.mgnix.apps.direnv;
in {
  options.mgnix.apps.direnv = {
    enable = mkEnableOption "direnv";
  };
  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = config.mgnix.apps.zsh.enable;
      nix-direnv.enable = true;
    };
  };
}

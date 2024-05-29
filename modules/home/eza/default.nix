{
  config,
  lib,
  ...
}:
with lib; {
  programs = {
    eza = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = config.mgnix.apps.zsh.enable;
      icons = true;
      git = true;
    };

    zsh.shellAliases = mkIf config.mgnix.apps.zsh.enable {
      l = "eza -lag";
    };
  };
}

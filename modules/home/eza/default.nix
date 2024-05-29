{
  config,
  lib,
  ...
}:
with lib; {
  programs = let
    aliases = {
      l = "eza -lag";
    };
  in {
    eza = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = config.mgnix.apps.zsh.enable;
      icons = true;
      git = true;
    };

    zsh.shellAliases = mkIf config.mgnix.apps.zsh.enable aliases;
    bash.shellAliases = aliases;
  };
}

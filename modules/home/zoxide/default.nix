{config, ...}: {
  programs = let
    aliases = {
      zz = "z -";
    };
  in {
    zoxide = {
      enable = true;
      enableZshIntegration = config.mgnix.apps.zsh.enable;
      enableBashIntegration = true;
    };

    zsh.shellAliases = aliases;
    bash.shellAliases = aliases;
  };
}

{config, ...}: {
  programs.zoxide = {
    enable = true;
    enableZshIntegration = config.mgnix.apps.zsh.enable;
  };
}

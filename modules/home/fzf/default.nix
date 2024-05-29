{config, ...}: {
  home.sessionVariables = {
    FZF_DEFAULT_COMMAND = "rg --files | sort -u";
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = config.mgnix.apps.zsh.enable;
  };
}

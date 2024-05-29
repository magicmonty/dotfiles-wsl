{
  config,
  lib,
  ...
}:
with lib; {
  programs = {
    bat = {
      enable = true;
      config = {
        theme = "base16-256";
        "italic-text" = "always";
      };
    };

    zsh.shellAliases = mkIf config.mgnix.apps.zsh.enable {
      cat = "bat";
    };
  };
}

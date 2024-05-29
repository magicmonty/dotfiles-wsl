{
  config,
  lib,
  ...
}:
with lib; let
  aliases = {
    cat = "bat";
  };
in {
  programs = {
    bat = {
      enable = true;
      config = {
        theme = "base16-256";
        "italic-text" = "always";
      };
    };

    zsh.shellAliases = mkIf config.mgnix.apps.zsh.enable aliases;
    bash.shellAliases = aliases;
  };
}

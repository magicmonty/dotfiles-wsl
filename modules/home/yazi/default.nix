{
  config,
  lib,
  ...
}:
with lib; {
  programs = {
    yazi.enable = true;
    zsh.shellAliases = mkIf config.mgnix.apps.zsh.enable {
      ranger = "yazi";
      "r." = "yazi .";
      "e." = "yazi .";
    };
  };
}

{
  config,
  lib,
  ...
}:
with lib; {
  programs = let
    aliases = {
      ranger = "yazi";
      "r." = "yazi .";
      "e." = "yazi .";
    };
  in {
    yazi.enable = true;
    zsh.shellAliases = mkIf config.mgnix.apps.zsh.enable aliases;
    bash.shellAliases = aliases;
  };
}

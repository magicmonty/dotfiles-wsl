{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.mgnix.apps.home-manager;
in {
  options.mgnix.apps.home-manager = {
    enable = mkEnableOption "home-manager";
  };

  config = {
    programs.home-manager.enable = cfg.enable;
  };
}

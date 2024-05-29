{lib, ...}:
with lib.mgnix; {
  config = {
    home.username = "mgondermann";
    home.stateVersion = "24.05";

    mgnix = {
      apps = {
        neovim.lite = true;
        zsh.wslIntegration = true;

        git = {
          user = "Martin Gondermann";
          email = "martin.gondermann@bayoo.net";
        };

        home-manager = enabled;
        direnv = enabled;
      };
    };
  };
}

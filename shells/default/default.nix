{
  mkShell,
  inputs,
  pkgs,
  ...
}: let
  check = inputs.pre-commit-hooks.lib.${pkgs.system}.run {
    src = ./.;
    hooks = {
      statix.enable = true;
      alejandra.enable = true;
    };
  };
in
  mkShell {
    inherit (check) shellHook;
    buildInputs = check.enabledPackages;
  }

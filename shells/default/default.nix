{
  mkShell,
  inputs,
  system,
  ...
}: let
  check = inputs.pre-commit-hooks.lib.${system}.run {
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
    # inherit (outputs.checks.${system}.pre-commit-check) shellHook;
    # buildInputs = outputs.checks.${system}.pre-commit-check.enabledPackages;
  }

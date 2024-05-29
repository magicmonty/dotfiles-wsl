{
  inputs,
  system,
  ...
}:
inputs.pre-commit-hooks.lib.${system}.run {
  src = ./.;
  hooks = {
    statix.enable = true;
    alejandra.enable = true;
  };
}

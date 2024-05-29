{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    unstable.url = "nixpkgs/nixos-unstable";

    # The name "snowfall-lib" is required due to how Snowfall Lib processes your
    # flake's inputs.
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:magicmonty/nixvim";
      inputs.nixpkgs.follows = "unstable";
    };
  };

  # We will handle this in the next section.
  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;

      snowfall = {
        namespace = "mgnix";

        meta = {
          name = "mgnix";
          title = "Magicmonty's nix config";
        };
      };

      channels-config = {
        allowUnfree = true;
      };
    };
}

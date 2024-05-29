{inputs, ...}: final: prev: {
  neovim = inputs.nixvim.packages.${prev.system}.default;
  neovim-lite = inputs.nixvim.packages.${prev.system}.lite;
}

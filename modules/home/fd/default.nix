_: {
  programs.fd = {
    enable = true;
    ignores = [".git/" "*.bak"];
    hidden = true;
  };
}

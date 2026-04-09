{ ... }:

{
  imports = [
    ./auto_include.nix
    ./browser
    ./terminal
    ./shell
    ./fzf.nix
    ./direnv.nix
    ./ripgrep.nix
    ./kubernetes.nix
    ./claude.nix
  ];
}

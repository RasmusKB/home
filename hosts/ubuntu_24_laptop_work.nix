{
  config,
  extendedLib,
  pkgs,
  nixpkgs,
  nixGL,
  ...
}:

with extendedLib;
let
  cfg = config.home;
  lib = extendedLib;
in
{
  imports = [
    ../modules/home.nix
    ../modules/editors
    ../modules/misc
  ];

  home.username = "tcm873";
  home.homeDirectory = "/home/tcm873@ds.mot.com";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    nixgl.nixGLIntel
  ];

  targets.genericLinux.nixGL = {
    packages = nixGL.packages; # you must set this or everything will be a noop
    defaultWrapper = "mesa"; # choose from options
    installScripts = ["mesa"];
    vulkan.enable = false;
  };

  nixpkgs.config.allowUnfreePredicate = _: true;

  modules.editors.neovim.enable = true;

  modules.misc = {
    direnv.enable = true;
    kubernetes.enable = true;
    ripgrep.enable = true;
    shell.zsh.enable = true;
    terminal.alacritty.enable = true;
	browser.google_chrome.enable = true;
	fzf.enable = true;
  };

  home.file.".config/nix/" = {
    source = ../configs/nix;
    recursive = true;
  };

  programs.home-manager.enable = true;
  programs.command-not-found.enable = true;
}

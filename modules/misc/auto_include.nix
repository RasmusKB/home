{ pkgs, pkgs-stable, ... }:

{
  home.packages = with pkgs-stable; [
    # MISC
    pkgs-stable.firefox
    pkgs-stable.cachix
    pkgs-stable.networkmanagerapplet
    pkgs-stable.flameshot
    pkgs-stable.gnumake
    pkgs-stable.gdb
    pkgs-stable.nixfmt-classic
    pkgs-stable.git
    pkgs.nmap
    pkgs.whois
    pkgs.tcpdump
    pkgs.xclip
    pkgs.zathura
    pkgs.jq
    pkgs.yq-go
    pkgs.gh
    pkgs.delta
    pkgs.websocat
    pkgs.any-nix-shell
    pkgs.gotop
    pkgs.htop
    pkgs.neofetch
    pkgs.zip
    pkgs.unzip
    pkgs.gnupg
    pkgs.lazygit
		pkgs.ffmpeg
		pkgs.websocat
  ];
}

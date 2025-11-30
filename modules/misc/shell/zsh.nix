{ config, pkgs, extendedLib, ... }:

with extendedLib;
let
   cfg = config.modules.misc.shell.fish;
in
{
  options.modules.misc.shell.zsh = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      ohMyZsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "git"
          "sudo"
          "docker"
          "kubectl"
		  "mix"
        ];
      };
    };

    home.packages = with pkgs; [
      zoxide
    ];

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
  };
}

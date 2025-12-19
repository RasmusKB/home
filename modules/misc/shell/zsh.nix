{ config, pkgs, extendedLib, ... }:

with extendedLib;
let
   cfg = config.modules.misc.shell.zsh;
in
{
  options.modules.misc.shell.zsh = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
			initContent = lib.mkBefore ''
				ZSH_DISABLE_COMPFIX="true"
			'';
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "git"
          "sudo"
          "docker"
          "kubectl"
					"mix"
					"kubectl"
					"rust"
					"npm"
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

{ config, pkgs, extendedLib, nixGL, ... }:

with extendedLib;
let
   cfg = config.modules.misc.terminal.alacritty;
in
{
  options.modules.misc.terminal.alacritty = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.alacritty;

      settings = {
        window = {
          title = "Terminal";

          padding = { y = 5; x=5;};
          dimensions = {
            lines = 75;
            columns = 100;
          };
        };

        # 1. Running showkeys -a, alacritty doesn't distinguish
	# between Ctrl-Backspace and Backspace (both returns 0x7f)

	# 2. This makes Ctrl-Backspace unavailable in Tmux.
	# Solution: remap to <ESC><DEL>, which
	# is interpreted similar by Tmux and Alacritty.

	# 3. Neovim (and other applications) must remap <ESC><DEL> to
	# be interpreted as Ctrl-Backspace
        keyboard.bindings = [
            {
              key = "Back";
              mods = "Control";
              chars = "\\u001b\\u007f";
            }
          ];

        terminal.shell = { program = "${pkgs.zsh}/bin/zsh"; };
      };
    };
  };
}

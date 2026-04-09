{ config, pkgs, extendedLib, nixGL, ... }:

with extendedLib;
let
   cfg = config.modules.misc.terminal.tmux;
in
{
  options.modules.misc.terminal.tmux = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
    };

    home.file = {
      ".config/tmux" = {
        source = ../../../configs/tmux;
          recursive = true;
      };
    };
  };
}

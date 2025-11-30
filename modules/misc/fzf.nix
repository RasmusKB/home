{ config, pkgs, extendedLib, ... }:

with extendedLib;
let
   cfg = config.modules.misc.fzf;
in
{
  options.modules.misc.fzf = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    programs.fzf = {
      enable = true;
    };
  };
}

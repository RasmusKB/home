{ config, pkgs, pkgs-kubelogin, extendedLib, ... }:

with extendedLib;
let
   cfg = config.modules.misc.kubernetes;
in
{
  options.modules.misc.kubernetes = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.kind
      pkgs.ctlptl
      pkgs.tilt
      pkgs.kubectl
      pkgs.kubectx
      pkgs.kubernetes-helm
      pkgs.azure-cli
			pkgs.k9s

      pkgs-kubelogin.kubelogin
    ];
  };
}

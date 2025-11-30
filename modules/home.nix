{
  config,
  options,
  lib,
  pkgs,
  nixpkgs,
  specialArgs,
  ...
}:
with specialArgs.extendedLib;
let
  cfg = config.home;
in
{
  options.home = with types; {
    # file = mkOpt' attrs { } "Files to place directly in $HOME";
    configFile = mkOption { type = attrs; default = { }; description =  "Files to place in $XDG_CONFIG_HOME"; };
    dataFile = mkOption { type = attrs; default = { }; description = "Files to place in $XDG_DATA_HOME"; };
    fakeFile = mkOption { type = attrs; default = { }; description = "Files to place in $XDG_FAKE_HOME"; };

    dir = mkOption { type = str; default = "${config.home.homeDirectory}"; };
    binDir =    mkOption { type = str; default = "${cfg.dir}/.local/bin"; };
    cacheDir =  mkOption { type = str; default = "${cfg.dir}/.cache"; };
    configDir = mkOption { type = str; default = "${cfg.dir}/.config"; };
    dataDir =   mkOption { type = str; default = "${cfg.dir}/.local/share"; };
    stateDir =  mkOption { type = str; default = "${cfg.dir}/.local/state"; };
    fakeDir =   mkOption { type = str; default = "${cfg.dir}/.local/user"; };
  };

  config = {
    home.sessionVariables = mkOrder 10 {
      # These are the defaults, and xdg.enable does set them, but due to load
      # order, they're not set before environment.variables are set, which
      # could cause race conditions.
      XDG_BIN_HOME = cfg.binDir;
      XDG_CACHE_HOME = cfg.cacheDir;
      XDG_CONFIG_HOME = cfg.configDir;
      XDG_DATA_HOME = cfg.dataDir;
      XDG_STATE_HOME = cfg.stateDir;

      # This is not in the XDG standard. It's my jail for stubborn programs,
      # like Firefox, Steam, and LMMS.
      XDG_FAKE_HOME = cfg.fakeDir;
      XDG_DESKTOP_DIR = cfg.fakeDir;
      SHELL = "$HOME/.nix-profile/bin/zsh";
      TERMINAL = "alacritty";
    };

    xdg = {
      # enable = true;
      configFile = mkAliasDefinitions options.home.configFile;
      dataFile   = mkAliasDefinitions options.home.dataFile;

      # Force these, since it'll be considered an abstraction leak to use
      # home-manager's API anywhere outside this module.
      cacheHome  = mkForce cfg.cacheDir;
      configHome = mkForce cfg.configDir;
      dataHome   = mkForce cfg.dataDir;
      stateHome  = mkForce cfg.stateDir;
    };
  };
}

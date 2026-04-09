{ config, pkgs, extendedLib, lib, ... }:

with extendedLib;
let
  cfg = config.modules.misc.claude;

  # Directory config mapping
  # maps { subDir = "localPath"; }
  claudeDirs = {
    "workflows" = ../../configs/claude/workflows;
    "languages" = ../../configs/claude/languages;
    "projects"  = ../../configs/claude/projects;
  };

  # Helper: Generates the attribute set for home.file for a directory
  mkLinksForDir = subDir: sourcePath:
    let
      files = builtins.readDir sourcePath;
      mkLink = name: _: {
        name = ".claude/${subDir}/${name}";
        value = { source = "${sourcePath}/${name}"; };
      };
    in
      lib.mapAttrs' mkLink files;

in
{
  options.modules.misc.claude = {
    enable = mkBoolOpt false;

    aliases = mkOption {
      type = types.attrsOf types.str;
      default = {
        "fix-pr" = "claude '@~/.claude/workflows/fix-pr.md'";
      };
    };
  };

	config = mkIf cfg.enable {
    home.file = mkMerge [
      # 1. Link the baseline Router file
      {
        ".claude/CLAUDE.md".source = ../../configs/claude/CLAUDE.md;
      }

      # 2. Merge all contents of our library folders
      (mkMerge (
        lib.mapAttrsToList (subDir: path: mkLinksForDir subDir path) claudeDirs
      ))
    ];

    # 3. Environment plumbing
    home.packages = [ pkgs.gh ];
    programs.zsh.shellAliases = cfg.aliases;
    programs.bash.shellAliases = cfg.aliases;
  };
}

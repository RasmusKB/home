{ config, pkgs, extendedLib, ... }:

with extendedLib;
let
  cfg = config.modules.misc.ai;
in
{
  options.modules.misc.ai = {
    enable = mkBoolOpt false;

    workflows = {
      enable = mkBoolOpt true;
      source = mkOption {
        type = types.path;
        default = ../../configs/ai/workflows;
        description = "Path to AI workflow files";
      };
    };

    aliases = mkOption {
      type = types.attrsOf types.str;
      default = {
        "fix-pr" = "claude 'Follow the instructions located at .claude/workflows/example.md'";
      };
      description = "Shell aliases for AI workflows that tell Claude to follow workflow instructions";
    };
  };

  config = mkIf cfg.enable {
    # Symlink workflow files to .claude/workflows/
    home.file = mkIf cfg.workflows.enable (
      let
        workflowFiles = builtins.readDir cfg.workflows.source;
        mkWorkflowLink = name: _: {
          name = ".claude/workflows/${name}";
          value = {
            source = "${cfg.workflows.source}/${name}";
          };
        };
      in
        lib.mapAttrs' mkWorkflowLink workflowFiles
    );

    # Add shell aliases
    programs.zsh.shellAliases = cfg.aliases;
    programs.bash.shellAliases = cfg.aliases;
  };
}

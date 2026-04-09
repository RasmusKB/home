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

    claudeConfig = {
      enable = mkBoolOpt true;
      source = mkOption {
        type = types.path;
        default = ../../configs/ai/CLAUDE.md;
        description = "Path to CLAUDE.md baseline prompt configuration";
      };
    };

    aliases = mkOption {
      type = types.attrsOf types.str;
      default = {
        "fix-pr" = "claude 'Follow the instructions located at ~/.claude/workflows/fix-pr.md'";
      };
      description = "Shell aliases for AI workflows that tell Claude to follow workflow instructions";
    };
  };

  config = mkIf cfg.enable {
    # Symlink workflow files to .claude/workflows/
    home.file = mkMerge [
      (mkIf cfg.workflows.enable (
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
      ))

      # Symlink CLAUDE.md to .claude/
      (mkIf cfg.claudeConfig.enable {
        ".claude/CLAUDE.md" = {
          source = cfg.claudeConfig.source;
        };
      })
    ];

    # Add shell aliases
    programs.zsh.shellAliases = cfg.aliases;
    programs.bash.shellAliases = cfg.aliases;
  };
}

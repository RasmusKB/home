{ config, pkgs-stable, extendedLib, ... }:

with extendedLib;
let
   cfg = config.modules.editors.neovim;
in
{

  options.modules.editors.neovim = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    programs.neovim.enable = true;

    programs.neovim.plugins = with pkgs-stable; [
	  vimPlugins.bufferline-nvim
	  vimPlugins.cmp-nvim-lsp
	  vimPlugins.dashboard-nvim
 	  vimPlugins.diffview-nvim
	  vimPlugins.flash-nvim
	  vimPlugins.gruvbox
	  vimPlugins.lazy-nvim
	  vimPlugins.lualine-nvim
	  vimPlugins.mason-lspconfig-nvim
	  vimPlugins.mason-nvim
	  vimPlugins.mini-icons
	  vimPlugins.neogit
	  vimPlugins.noice-nvim
	  vimPlugins.nui-nvim
	  vimPlugins.nvim-cmp
	  vimPlugins.nvim-jdtls
	  vimPlugins.nvim-lspconfig
	  vimPlugins.nvim-surround
	  vimPlugins.nvim-treesitter
	  vimPlugins.nvim-web-devicons
	  vimPlugins.plenary-nvim
	  vimPlugins.project-nvim
	  vimPlugins.rainbow-delimiters-nvim
	  vimPlugins.snacks-nvim
	  vimPlugins.telescope-file-browser-nvim
	  vimPlugins.telescope-nvim
	  vimPlugins.trouble-nvim
	  vimPlugins.vim-floaterm
    ];

    home.packages = with pkgs-stable; [
      luarocks
      lua5_1
    ];

    home.file = {
      ".config/nvim" = {
        source = ../../configs/nvim;
        recursive = true;
      };
    };
  };
}

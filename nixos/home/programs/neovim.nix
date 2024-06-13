{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    ripgrep
    lua-language-server
    pyright
  ];

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      LazyVim
      lazy-lsp-nvim
    ];
  };

  home.file."./.config/nvim/" = {
    source = ../dotfiles/nvim;
    recursive = true;
  };
}

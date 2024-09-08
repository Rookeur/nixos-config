{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fd
    fzf
    ripgrep
    lazygit

    # lsp
    bash-language-server
    docker-compose-language-service
    dockerfile-language-server-nodejs
    buf-language-server
    solc
    python312Packages.python-lsp-server
    helm-ls
    nil
    yaml-language-server
    gopls

    # linter
    ansible-lint
    cmake-lint
    commitlint
    mypy
    nodePackages.jsonlint
    protolint
    pylint
    shellcheck
    tflint
    typos
    yamllint
    write-good

    # formatter
    black
    isort
    jq
    nixpkgs-fmt
    shfmt
    stylua
    yamlfmt

    # bin
    protobuf
    protobufc
    lldb
    bashdb
    rustc
  ];

  programs.neovim = {
    enable = true;
    withNodeJs = true;
    # plugins = with pkgs.vimPlugins; [];
  };

  home.file."./.config/nvim/init.lua".text = ''
    require("config.lazy")
    local status, ts_install = pcall(require, "nvim-treesitter.install")
    if(status) then
        ts_install.compilers = { "${pkgs.gcc}/bin/gcc" }
    end
  '';

  home.file."./.config/nvim/" = {
    source = ../dotfiles/nvim;
    recursive = true;
  };

}

{ config, lib, pkgs, ... }:

{
  home.username = "adrien";
  home.homeDirectory = "/home/adrien";
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  services.poweralertd.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    (discord.override { nss = nss_latest; })
    apache-directory-studio
    arandr
    awscli2
    bat
    bear
    bitwarden
    blueman
    brightnessctl
    cargo
    chromium
    clang-tools
    conky
    criterion
    dig
    docker
    docker-compose
    dunst
    feh
    file
    flameshot
    font-manager
    gdb
    git-lfs
    go
    gopls
    graphviz
    htop
    hugo
    inconsolata-nerdfont
    iosevka
    jdk
    jq
    libnotify
    libreoffice
    libyamlcpp
    lua53Packages.lua-lsp
    nerdfonts
    nitrogen
    nodePackages_latest.bash-language-server
    nodePackages_latest.dockerfile-language-server-nodejs
    nodePackages_latest.typescript-language-server
    nodePackages_latest.vscode-langservers-extracted
    nodePackages_latest.yaml-language-server
    nodejs
    noto-fonts-emoji
    olvid
    openssl
    openvpn
    pandoc
    papirus-icon-theme
    pavucontrol
    picom
    poetry
    postgresql
    pulseaudio
    remmina
    slack
    slrn
    sqlfluff
    sqls
    sshfs
    sumneko-lua-language-server
    thunderbird
    tree
    unzip
    valgrind
    virt-manager
    virtualbox
    vscodium
    weechat
    wireguard-tools
    wireshark
    xdg-utils
    xfce.xfce4-terminal
    xidlehook
    xsel
    xss-lock
    xz
    yamllint
    yarn
    yq
    zathura
    zip
    zlib
  ];

  imports = [
    ../../programs/git.nix
    ../../programs/gpg.nix
    ../../programs/zsh.nix
    ../../programs/neovim.nix
  ];
}

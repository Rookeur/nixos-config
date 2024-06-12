{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    tig
  ];

  programs.git = {
    enable = true;
    lfs.enable = true;
    userEmail = "adrien.langou@epita.fr";
    userName = "Adrien Langou";
    signing = {
      key = "3B8FFC4100942CB45A2A7DF25A44DA8F907191B0";
      gpgPath = "gpg2";
      signByDefault = true;
    };
    aliases = {
      l = "log --oneline --graph --decorate";
      sw = "switch";
      st = "status";
      cm = "commit";
    };

    extraConfig = {
      core = {
        editor = "nvim";
        excludesfile = "~/.gitignore";
      };
      commit = {
        verbose = true;
      };
      pull = {
        rebase = true;
      };
      rebase = {
        autoSquash = true;
        autoStash = true;
      };
      color = {
        ui = true;
      };
      merge = {
        conflictstyle = "diff3";
      };
      push = {
        default = "simple";
        autoSetupRemote = true;
      };
      branch = {
        autosetuprebase = "always";
      };
    };

    includes = [
      {
        condition = "gitdir:~/EPITA/prologin/";
        contents = {
          user = {
            email = "adrien.langou@prologin.org";
          };
        };
      }
    ];
  };
}

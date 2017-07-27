{
  allowUnfree = true;
  wine.build = "wine32";

  firefox = {
    enableAdobeFlash = true;
  };

  packageOverrides = super: let self = super.pkgs; in {
    # jdk = pkgs.oraclejdk8;
    # ruby = pkgs.ruby_1_9_3;
    # nodejs = pkgs.nodejs-6_x;
    # npm2nix = pkgs.nodePackages_4_x.npm2nix;
    # nodePackages = pkgs.nodePackages_6_x;
    # idea14_oracle = pkgs.idea.idea14-community.override {
    #   jdk = pkgs.oraclejdk8;
    # };

    # idea15_ult_oracle = pkgs.idea.idea-ultimate.override {
    #   jdk = pkgs.oraclejdk8;
    # };

    # rEnv = super.rWrapper.override {
    #   packages = with self.rPackages; [
    #     devtools
    #     ggplot2
    #     reshape2
    #     yaml
    #     optparse
    #     data_table
    #   ];
    # };

    rstudioEnv = super.rstudioWrapper.override {
      packages = with self.rPackages; [
        tidyverse pryr htmltools htmlwidgets
      ];
      # R = self.rEnv;
      #   useRPackages = true;
    };

    myPackages = with self; [
      stack deluge skype slack vlc mc chromium sublime3
      bind nix-repl glxinfo pciutils usbutils coreutils
      playonlinux wine
      git nix-prefetch-git wget
      calibre
    ];

    myemacs = super.emacsWithPackages (with self.emacsPackagesNg; [
      magit

      melpaPackages.haskell-mode
      melpaPackages.intero

      # auctex
      melpaPackages.js2-mode
      melpaPackages.tern

      melpaPackages.lua-mode
      melpaPackages.nix-mode
      melpaPackages.color-theme-solarized

      melpaPackages.dockerfile-mode

      # melpaPackages.helm-projectile
      melpaPackages.ensime
      melpaPackages.scala-mode
      melpaPackages.jdee

      # melpaPackages.dirtree
    ]);

    # ghc = pkgs.haskellPackages.ghcWithPackages (hpkgs : [
    #   hpkgs.suffixtree
    # ]);

  };

}

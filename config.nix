{
  allowUnfree = true;
  # wine.build = "wine32";
  # wine = {
    # build = "wineWow";
    # release = "staging";
  # };

  firefox = {
    enableAdobeFlash = true;
  };

  # chromium = {
  #   enablePepperFlash = false;
  # };

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

    vowpal-wabbit = super.callPackage ({
      stdenv, fetchgit, llvmPackages, boost, zlib, jdk, which
      }:
      stdenv.mkDerivation {
        name = "vowpal-wabbit";
        buildInputs = [ llvmPackages.clang-unwrapped boost zlib jdk which ];
        patchPhase = ''
          substituteInPlace Makefile --replace "/usr/local" "$out"
          substituteInPlace vowpalwabbit/Makefile --replace "/usr/local" "$out"
          substituteInPlace java/Makefile --replace "/usr" "$out"
          substituteInPlace cluster/Makefile --replace "/usr/local" "$out"
        '';
        preInstall = ''
          mkdir -p $out/bin
          mkdir -p $out/lib
          mkdir -p $out/include
        '';
        src = fetchgit {
          url = "https://github.com/JohnLangford/vowpal_wabbit.git";
          sha256 = "0h7kn2152hf199b920a797fxmlg15n1r94878dv0nryh3qnb3ab5";
          rev = "77753f0a8e73ea372ad25f24abd710f278975efc";
        };
      }
    ) { };

    rstudioEnv = super.rstudioWrapper.override {
      packages = with self.rPackages; [
        tidyverse pryr htmltools htmlwidgets
      ];
      # R = self.rEnv;
      #   useRPackages = true;
    };

    myPackages = with self; [
      chromium firefox flashplayer-standalone
      stack vlc mc sublime3 adobe-reader
      bind glxinfo pciutils usbutils coreutils
      tcpdump ipcalc
      playonlinux wine-staging dosbox
      git nix-prefetch-git wget gnupg
      calibre
      # ubix stuff
      maven sbt openjdk myPython gnumake gcc
      nodejs nodePackages.bower nodePackages.grunt-cli nodePackages.gulp
      racket
      vowpal-wabbit

      # amule
      pythonPackages.grip deluge

      pstree tree htop tmux

      lxc

      emacs vim postman

      spark hadoop mesos mongodb
      kafkacat zookeeper cassandra

      # soundfont-fluid qsynth audacity

      singular

      jetbrains.idea-ultimate slack

      ansible

      # on dell: flashplayer-standalone, firefox, aMule
      # idea-ultimate, sbt
      # Fluid, qsynth, audacity
      # singular
      # lm-sensors, gjs, emacs, python2.7-grip
    ];

    flakeyPackages = with self; [
      mytexlive
      amule
      skypeforlinux
      rstudioEnv
    ];

    mytexlive = super.texlive.combine {
      # inherit (super.texlive) moderncv collection-fontsextra;
      inherit(super.texlive) scheme-full;
    };

    myPython = super.python27.withPackages (ps : [ ps.pip ps.setuptools ]);

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
      # melpaPackages.jdee

      # melpaPackages.dirtree
    ]);

    # ghc = pkgs.haskellPackages.ghcWithPackages (hpkgs : [
    #   hpkgs.suffixtree
    # ]);

  };

}

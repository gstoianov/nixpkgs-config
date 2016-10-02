{
  allowUnfree = true;

  firefox = {
    enableAdobeFlash = true;
  };
  
  packageOverrides = pkgs: {
    # jdk = pkgs.oraclejdk8;
    ruby = pkgs.ruby_1_9_3;
    nodejs = pkgs.nodejs-6_x;
    nodePackages = pkgs.nodePackages_6_x;
    idea14_oracle = pkgs.idea.idea14-community.override {
      jdk = pkgs.oraclejdk8;
    };

    idea15_ult_oracle = pkgs.idea.idea-ultimate.override {
      jdk = pkgs.oraclejdk8;
    };

    myemacs = pkgs.emacsWithPackages (with pkgs.emacsPackagesNg; [
      magit haskell-mode
      # auctex
      melpaPackages.js2-mode
      melpaPackages.tern
      
      melpaPackages.lua-mode
      melpaPackages.nix-mode
      melpaPackages.color-theme-solarized

      melpaPackages.dockerfile-mode

      melpaPackages.helm-projectile
      melpaPackages.ensime
      melpaPackages.scala-mode
      melpaPackages.jdee

      melpaPackages.dirtree
    ]);

    ghc = pkgs.haskell.packages.ghc7103.ghcWithPackages (hpkgs : [
      hpkgs.suffixtree
    ]);

  };

}

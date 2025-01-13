{ config, pkgs, lib, ... }:
let
  # Define fetch-nvim derivation
  fetch-nvim = pkgs.stdenv.mkDerivation {
    name = "fetch-nvim";

    src = pkgs.fetchgit {
      url = "https://github.com/Muffeter/nvim.git";
      rev = "96c2b27fcc2399f17f01a0493b5ae64dc2fbb25b";
      sha256 = "sha256-ZElYG0ro+MclyWRLFJ/J9HCLbeCKAMP1P96W5YYIGB0=";
    };

    installPhase = ''
      mkdir -p $out/nvim
      cp -r $src/* $out/nvim
    '';
  };
in
{

  home.activation.copyNvimConfig = lib.mkAfter ''
    #!/usr/bin/env bash
    echo "Copying Neovim configuration to ~/.config/nvim"
    mkdir -p ${config.home.homeDirectory}/.config/nvim
    cp -rf ${fetch-nvim}/nvim/* ${config.home.homeDirectory}/.config/nvim
    chmod -R 755 ${config.home.homeDirectory}/.config/nvim
  '';
}

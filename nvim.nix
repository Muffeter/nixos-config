{ config, pkgs, lib, ... }:
let
  # Define fetch-nvim derivation
  fetch-nvim = pkgs.stdenv.mkDerivation {
    name = "fetch-nvim";

    src = pkgs.fetchgit {
      url = "https://github.com/Muffeter/nvim.git";
      rev = "9f6e4895e0cfab6f31f024ae06f181b1050d36c5";
      sha256 = "whbvtG4k3OvcncV6ANBv30mAwf+wb3NY1pZLvP0Ocgk=";
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

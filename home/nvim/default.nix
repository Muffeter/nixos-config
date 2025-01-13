{ config, pkgs, lib, ... }:
let
  # Define fetch-nvim derivation
  fetch-nvim = pkgs.stdenv.mkDerivation {
    name = "fetch-nvim";

    src = pkgs.fetchgit {
      url = "https://github.com/Muffeter/nvim.git";
      rev = "aa697426b69f5a0ab7c0c3b84ebbcce08c8d46cf";
      sha256 = "sha256-KTE4FlDu+h2orGbhWPf2Z24cSLlebAxP2pXYk0fzvDA=";
    };

    installPhase = ''
      mkdir -p $out/nvim
      cp -r $src/* $out/nvim
    '';
  };
in
{

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      lazy-nvim
      nvim-treesitter.withAllGrammars
    ];
  };

  home.activation.copyNvimConfig = lib.mkAfter ''
    #!/usr/bin/env bash
    echo "Copying Neovim configuration to ~/.config/nvim"
    mkdir -p ${config.home.homeDirectory}/.config/nvim
    cp -rf ${fetch-nvim}/nvim/* ${config.home.homeDirectory}/.config/nvim
    chmod -R 755 ${config.home.homeDirectory}/.config/nvim
  '';
}

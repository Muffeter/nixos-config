{ config, pkgs, lib, ... }:
{
  imports = [
    ../../home/nvim
    ../../home/misc
  ];
  home.username = "ming";
  home.homeDirectory = "/home/ming";
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };
  home.packages = with pkgs;[
    neofetch
    which
    nix-output-monitor

    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files
    lemonade
    fish
    nixd
  ];

  programs.fish = {
    enable = true;
    shellAliases = {
      sw = "sudo nixos-rebuild switch";
    };
  };

  # git 
  programs.git = {
    enable = true;
    userName = "Muffeter";
    userEmail = "sonmu.def@gmail.com";
  };


  # programs.bash = {
  #   enable = true;
  #   enableCompletion = true;
  #   # TODO  bashrc 
  #   bashrcExtra = ''
  #     export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
  #   '';
  # };

  # programs.lemonade = {
  #   enable = true;
  # };

  #xdg.configFile."nvim".source = $HOME/nvim;
  home.stateVersion = "21.05";

  programs.home-manager.enable = true;
}

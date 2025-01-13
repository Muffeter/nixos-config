{ config, pkgs, lib, ... }:


{
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
  ];

  # git 
  programs.git = {
    enable = true;
    userName = "Muffeter";
    userEmail = "sonmu.def@gmail.com";
  };


  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO  bashrc 
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';
  };
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
        nvim-lspconfig
        lazy-nvim
        nvim-treesitter.withAllGrammars
    ];
  };

  home.file."lemonade.toml".text = ''
port = 3333
host = '192.168.1.1'
  '';
 imports = [ ./nvim.nix ];

  #xdg.configFile."nvim".source = $HOME/nvim;
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}

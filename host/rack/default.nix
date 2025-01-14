{config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    
    
  ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = false;
  networking.hostName = "racknerd-e6845e";
  networking.domain = "";
  users.users.root.openssh.authorizedKeys.keys = [''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICx/NKon/8VBF3Bld4NvUIBdhgqxE8/VFWPJaPUvNR5u ming@LDS'' ];
  i18n.defaultLocale = "en_US.UTF-8";


  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    curl
    git
    gcc
    fish
  ];

  users.users.ming = {
    isNormalUser = true;
    description = "ming";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  programs.fish = {enable = true;};

  environment.shellAliases = {
    sw = "sudo nixos-rebuild switch";
  };

   # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  system.stateVersion = "23.11";
}

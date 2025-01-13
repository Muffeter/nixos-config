# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hiMing"; # Define your hostname.

  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  networking.interfaces."ens33".ipv4.routes = [
  {
    address = "192.168.1.0";
    prefixLength = 24;
    via = "192.168.1.2";
  }
  ];
  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

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

  users.defaultUserShell = pkgs.fish;
  users.users.ming = {
    isNormalUser = true;
    description = "ming";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  programs.fish = {
    enable = true;
  };

   # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.stateVersion = "25.05"; # Did you read the comment?

}


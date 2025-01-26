{pkgs,... }: {
  imports = [
    ./hardware-configuration.nix
    
    
  ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "rainyun";
  networking.domain = "rainyun";
  services.openssh.enable = true;
  networking.firewall.enable = false;
  users.users.root.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOKj+SEeluP2J2Pd3flpELTXsj5axIxzmmMBTIZZaAH9 ming@DESKTOP-2FN6259
"];
  virtualisation.docker.enable = true;


nix.settings.substituters = [ "https://mirror.sjtu.edu.cn/nix-channels/store" ];
nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
  ];
  users.users.ming = {
    isNormalUser = true;
    description = "ming";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish;
  };

  programs.fish = {enable = true;};

  environment.shellAliases = {
    sw = "sudo nixos-rebuild switch";
  };

  system.stateVersion = "23.11";
}

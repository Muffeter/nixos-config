{pkgs,... }: {
  imports = [
    ./hardware-configuration.nix
    ../../docker/teamspeak
    ../../docker/momWechat
    ../../docker/langbot
  ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "rainyun";
  networking.domain = "rainyun";
  services.openssh.enable = true;
  networking.firewall.enable = false;
  users.users.root.openssh.authorizedKeys.keys = [
"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOKj+SEeluP2J2Pd3flpELTXsj5axIxzmmMBTIZZaAH9 ming@DESKTOP-2FN6259"
"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGV1sRtpYjmXN3PpIrpqvmJDgvJ6j3TwvAim9aMI5dPz ming@rack"

];
  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings = {
    registry-mirrors= ["https://docker.son5mu.win"];
};


#nix.settings.substituters = [ "https://mirror.sjtu.edu.cn/nix-channels/store" ];
nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    just
    fish
  ];
  users.users.ming = {
    isNormalUser = true;
    description = "ming";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish;
  };
  users.users.root = {
	shell = pkgs.fish;
};

  programs.fish = {enable = true;};
  system.stateVersion = "23.11";
}

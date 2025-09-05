{pkgs,... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "rainyun";
  networking.domain = "rainyun";
  services.openssh.enable = true;
  networking.interfaces."ens18".addresses = [
	{
		address = "172.16.103.125";
		prefixLength = 16;
	}
  ];
  users.users.root.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOKj+SEeluP2J2Pd3flpELTXsj5axIxzmmMBTIZZaAH9 ming@DESKTOP-2FN6259
"];
nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
  ];

  system.stateVersion = "23.11";
}

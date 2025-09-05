{pkgs,... }: {
  imports = [
    ./hardware-configuration.nix
    ../../docker/teamspeak
    ../../docker/mosdns
    # ../../docker/momWechat
    # ../../docker/langbot
    # ../../docker/filebox
    # ../../docker/aria2pro
  ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "rainyun";
  networking.domain = "rainyun";
  services.openssh.enable = true;
  networking.defaultGateway = {
	 address = "172.16.0.1";
	interface = "ens18";
  };
  networking.firewall.enable = false;
  networking.interfaces."ens18".ipv4.addresses = [
	{
		address = "172.16.103.125";
		prefixLength = 16;
	}
  ];
  users.users.root.openssh.authorizedKeys.keys = [
"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOKj+SEeluP2J2Pd3flpELTXsj5axIxzmmMBTIZZaAH9 ming@DESKTOP-2FN6259"
"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGV1sRtpYjmXN3PpIrpqvmJDgvJ6j3TwvAim9aMI5dPz ming@rack"

];
  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings = {
    registry-mirrors= ["https://docker.son5mu.win"];
};


nix.settings.experimental-features = [ "nix-command" "flakes" ];
nix.settings.substituters = [ "https://mirrors.cernet.edu.cn/nix-channels/store" ];
  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    just
    fish
    (let base = pkgs.appimageTools.defaultFhsEnvArgs; in
      pkgs.buildFHSUserEnv (base // {
      name = "fhs";
      targetPkgs = pkgs: 
        # pkgs.buildFHSUserEnv 只提供一个最小的 FHS 环境，缺少很多常用软件所必须的基础包
        # 所以直接使用它很可能会报错
        #
        # pkgs.appimageTools 提供了大多数程序常用的基础包，所以我们可以直接用它来补充
        (base.targetPkgs pkgs) ++ (with pkgs; [
          pkg-config
          ncurses
          # 如果你的 FHS 程序还有其他依赖，把它们添加在这里
        ]
      );
      profile = "export FHS=1";
      runScript = "bash";
      extraOutputsToInstall = ["dev"];
    }))
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

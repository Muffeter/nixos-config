{config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../docker/vaultwarden
    ../../docker/reader
  ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = false;
  networking.hostName = "rack";
  networking.domain = "";
  networking.firewall.enable = false;
  users.users.root.openssh.authorizedKeys.keys = [''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICx/NKon/8VBF3Bld4NvUIBdhgqxE8/VFWPJaPUvNR5u ming@LDS'' ];
  i18n.defaultLocale = "en_US.UTF-8";


  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  virtualisation.docker.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    curl
    git
    gcc
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

  programs.fish = {enable = true;};

  environment.shellAliases = {
    sw = "sudo nixos-rebuild switch";
  };

   # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  system.stateVersion = "23.11";
}

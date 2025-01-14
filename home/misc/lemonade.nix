{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.lemonade;
in
{
  options = {
    lemonade = {
      enable = mkEnableOption "Enable lemonade";
      port = mkOption {
        type = types.str;
        default = "3333";
        description = "port for lemonade";
      };
      host = mkOption {
        type = types.str;
        default = "192.168.1.1";
        description = "host for lemonade";
      };
    };
  };
  config = mkIf (cfg.enable or false) {
    home.file."lemonade.toml".text = ''
      port = "${cfg.port}"
      host = "${cfg.host}"
    '';

  };

}

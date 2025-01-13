{config, ...}: 
{
  home.file."lemonade.toml".text = ''
    port = 3333
    host = '192.168.1.1'
  '';

}

{
  nixpkgs,
	home-manager,
	...
}@inputs : let
      mkNixOS =
        system: config:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.ming = import ../users/ming/home.nix;
          home-manager.backupFileExtension = "backup";
        }
            config
          ];
        };
in 
{
  rainyun = mkNixOS "x86_64-linux" ../host/rain;


}

{
  description = "A template that shows all standard flake outputs";

  inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  home-manager.url = "github:nix-community/home-manager/release-24.11";
  home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self,  nixpkgs , home-manager, ... } @inputs: 
  {
	nixosConfigurations = import ./output/flake-module.nix { inherit nixpkgs home-manager; };
	};
}

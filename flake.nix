{
  description = "A template that shows all standard flake outputs";
  # The nixpkgs entry in the flake registry.
  inputs.nixpkgsRegistry.url = "nixpkgs";

  # The nixpkgs entry in the flake registry, overriding it to use a specific Git revision.
  inputs.nixpkgsRegistryOverride.url = "nixpkgs/a3a3dda3bacf61e8a39258a0ed9c924eeca8e293";

  # The master branch of the NixOS/nixpkgs repository on GitHub.
  inputs.nixpkgsGitHub.url = "github:NixOS/nixpkgs";

  # The nixos-20.09 branch of the NixOS/nixpkgs repository on GitHub.
  inputs.nixpkgsGitHubBranch.url = "github:NixOS/nixpkgs/nixos-20.09";

  # A specific revision of the NixOS/nixpkgs repository on GitHub.
  inputs.nixpkgsGitHubRevision.url = "github:NixOS/nixpkgs/a3a3dda3bacf61e8a39258a0ed9c924eeca8e293";

  # A flake in a subdirectory of a GitHub repository.
  inputs.nixpkgsGitHubDir.url = "github:edolstra/nix-warez?dir=blender";

  # A git repository.
  inputs.gitRepo.url = "git+https://github.com/NixOS/patchelf";

  # A specific branch of a Git repository.
  inputs.gitRepoBranch.url = "git+https://github.com/NixOS/patchelf?ref=master";

  # A specific revision of a Git repository.
  inputs.gitRepoRev.url = "git+https://github.com/NixOS/patchelf?ref=master&rev=f34751b88bd07d7f44f5cd3200fb4122bf916c7e";

  # A tarball flake
  inputs.tarFlake.url = "https://github.com/NixOS/patchelf/archive/master.tar.gz";

  # A GitHub repository.
  inputs.import-cargo = {
    type = "github";
    owner = "edolstra";
    repo = "import-cargo";
  };

  # Inputs as attrsets.
  # An indirection through the flake registry.
  inputs.nixpkgsIndirect = {
    type = "indirect";
    id = "nixpkgs";
  };


  # Transitive inputs can be overridden from a flake.nix file. For example, the following overrides the nixpkgs input of the nixops input:
  inputs.nixops.inputs.nixpkgs = {
    type = "github";
    owner = "NixOS";
    repo = "nixpkgs";
  };

  # It is also possible to "inherit" an input from another input. This is useful to minimize
  # flake dependencies. For example, the following sets the nixpkgs input of the top-level flake
  # to be equal to the nixpkgs input of the nixops input of the top-level flake:
  inputs.nixpkgs.url = "nixpkgs";
  inputs.nixpkgs.follows = "nixops/nixpkgs";


  # Work-in-progress: refer to parent/sibling flakes in the same repository
  inputs.home-manager.url = "github:nix-community/home-manager/release-24.11";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nixneovimplugins.url = "github:jooooscha/nixpkgs-vim-extra-plugins";




  outputs = { self,  nixpkgs , home-manager, ... } @inputs: {

    # Default overlay, for use in dependent flakes
    overlay = final: prev: { };

    # # Same idea as overlay but a list or attrset of them.
    overlays = { exampleOverlay = self.overlay; };

    # Same idea as nixosModule but a list or attrset of them.
    nixosModules = { exampleModule = self.nixosModule; };

    # Used with `nixos-rebuild --flake .#<hostname>`
    # nixosConfigurations."<hostname>".config.system.build.toplevel must be a derivation
    inputs.nixpkgs.overlay = [ inputs.nixneovimplugins.overlays.default ];

    nixosConfigurations.rainyun = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./host/rain
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.ming = import ./users/ming/home.nix;
          home-manager.backupFileExtension = "backup";
        }
      ];
    };
    nixosConfigurations.rack = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./host/rack
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.ming = import ./users/ming/home.nix;
          home-manager.backupFileExtension = "backup";
        }
      ];
    };
  };
}

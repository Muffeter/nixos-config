# nixos switch
sw:
    nixos-rebuild switch

# update software
up:
  nix flake update

# the nix history
history:
  nix profile history --profile /nix/var/nix/profiles/system

gc:
  # garbage collect all unused nix store entries
  sudo nix store gc --debug
  sudo nix-collect-garbage --delete-old


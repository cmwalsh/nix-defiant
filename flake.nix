{
  description = "Defiant configuration flake";
  
  inputs = {
    # Nix packages
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Nixos hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Disko
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let 

    # Configure stable packages
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";

      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };

    # Configure unstable packages
    pkgs-unstable = import inputs.nixpkgs-unstable {
      system = "x86_64-linux";

      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };
  
  in {
    
    nixosConfigurations = {
      # Framework Laptop
      "defiant" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit inputs;
          inherit pkgs-unstable;
        };

        modules = [
          ./config
        ];
      };
    };

    homeConfigurations = {
      # User Craig
      "craig" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        extraSpecialArgs = {
          inherit pkgs;
          inherit pkgs-unstable;
        };

        modules = [
          ./home/craig.nix
        ];
      };
    };
  };
}

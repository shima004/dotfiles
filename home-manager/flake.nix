{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, nix-darwin, ... }:
    let
      userConfig = import ./user.nix;
      isDarwin = builtins.match ".*-darwin" userConfig.system != null;
      pkgs = nixpkgs.legacyPackages.${userConfig.system};
    in
    {
      homeConfigurations."${userConfig.username}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
        extraSpecialArgs = { inherit userConfig; };
      };
    }
    // (if isDarwin then {
      darwinConfigurations."${userConfig.username}" = nix-darwin.lib.darwinSystem {
        system = userConfig.system;
        modules = [ ./darwin.nix ];
        specialArgs = { inherit userConfig; };
      };
    } else { });
}

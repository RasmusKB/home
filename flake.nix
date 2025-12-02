{
  description = "Home Manager configuration";

  inputs.nixpkgs-stable.url = "github:nixos/nixpkgs";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  # kubelogin 2.x has a persistent token bug. We revert to 0.1.7 found in nixpkgs: 0bd7f95e4588643f2c2d403b38d8a2fe44b0fc73
  # Found using: https://lazamar.co.uk/nix-versions/?channel=nixpkgs-unstable&package=kubelogin
  inputs.nixpkgs-kubelogin.url = "github:nixos/nixpkgs/0bd7f95e4588643f2c2d403b38d8a2fe44b0fc73";
  inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.nixGL.url = "github:nix-community/nixGL";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs =
    inputs@{
      self,
      nixGL,
      nixpkgs,
      nixpkgs-stable,
      nixpkgs-kubelogin,
      home-manager,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ nixGL.overlay ];
        config.allowUnfree = true;
      };

      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };

      pkgs-kubelogin = import nixpkgs-kubelogin {
        inherit system;
        config.allowUnfree = true;
      };

      args = { inherit self; inherit (nixpkgs) lib; inherit pkgs; };

      extendedLib = import ./lib args;

    in {
      environment.shells = with pkgs; [ zsh ];
      users.defaultUserShell = pkgs.zsh;

      packages.homeConfigurations = {
        rasmusbak =
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./hosts/ubuntu_22_04_laptop_home.nix ];
            extraSpecialArgs = { inherit pkgs-stable pkgs-kubelogin extendedLib nixGL; };
          };
        tcm873 =
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./hosts/ubuntu_24_laptop_work.nix ];
            extraSpecialArgs = { inherit pkgs-stable pkgs-kubelogin extendedLib nixGL; };
          };
      };

      packages.bootstrap = pkgs.writeShellApplication {
          name = "bootstrap";
          runtimeInputs = [ pkgs.git pkgs.home-manager ];
          text = ''
            DOT_DIR=$HOME/.config/home-manager

            if [ ! -d "$DOT_DIR" ]; then
            echo "==> $DOT_DIR doesn't exist, cloning into $DOT_DIR"
            git clone https://github.com/RasmusKB/home.git "$DOT_DIR"
            else
            echo "==> $DOT_DIR already exists, proceeding bootstrapping."
            fi

            home-manager switch -b backup --extra-experimental-features "nix-command flakes"
          '';
        };

    });
}

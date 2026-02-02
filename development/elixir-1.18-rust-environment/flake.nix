{
  description = "A devShell example";

  inputs = {
    nixpkgs.url      = "github:nixos/nixpkgs";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url  = "github:numtide/flake-utils";
		nixpkgs-openapi.url = "github:nixos/nixpkgs/01b6809f7f9d1183a2b3e081f0a1e6f8f415cb09";
  };

  outputs = { self, nixpkgs, nixpkgs-openapi, rust-overlay, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
				pkgsOpenApi = import nixpkgs-openapi {
					inherit system;
				};
				elixir = pkgs.beam.packages.erlang_27.elixir_1_18;
        beamPkg = pkgs.beam.packagesWith pkgs.erlang_27;
        elixir-ls = (beamPkg.elixir-ls.override {
          inherit elixir;
        });
      in
      {
        devShells.default = with pkgs; mkShell rec {
          nativeBuildInputs = [
						tree
            pkg-config
					  elixir
						elixir-ls
						nodejs_25
						jdk21
						pkgsOpenApi.openapi-generator-cli
          ];
          buildInputs = [
						openssl
						sqlx-cli
            rust-bin.stable."1.90.0".default
            protobuf
            rust-analyzer
            go
            cmake
          ];

          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
        };

      }
    );
}

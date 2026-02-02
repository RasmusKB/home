# https://github.com/NixOS/nixpkgs/pull/277180
{
  description = "Elixir development flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        elixir = pkgs.beam.packages.erlang_27.elixir_1_18;
        beamPkg = pkgs.beam.packagesWith pkgs.erlang_27;
        elixir-ls = (beamPkg.elixir-ls.override {
          inherit elixir;
        });
      in {

        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.gnumake
            pkgs.gcc
            pkgs.readline
            pkgs.openssl
            pkgs.zlib
            pkgs.libxml2
            pkgs.curl
            pkgs.libiconv
            elixir
            elixir-ls
            pkgs.rebar3
            pkgs.glibcLocales
            pkgs.postgresql
            pkgs.ctags
            pkgs.protobuf
            pkgs.erlang
            pkgs.kind
            pkgs.ctlptl
            pkgs.kubernetes-helm
            pkgs.kustomize
            pkgs.tilt
          ];

					nativeBuildInputs = [
						pkgs.pkg-config
					];
        };

      });
}

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
        elixir = pkgs.beam.packages.erlang_26.elixir_1_15;
        beamPkg = pkgs.beam.packagesWith pkgs.erlang_26;
        elixir-ls = (beamPkg.elixir-ls.override {
          mixRelease = beamPkg.mixRelease.override { elixir = elixir; };
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
          ];
        };

      });
}

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

        nodejs = pkgs.nodejs;

        asyncapi = pkgs.writeShellScriptBin "asyncapi" ''
					${nodejs}/bin/npx --yes @asyncapi/cli@2.16.0 "$@"
        '';

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
            pkgs.glibcLocales
            pkgs.postgresql
            pkgs.ctags
            pkgs.protobuf

            pkgs.erlang
            elixir
            elixir-ls
            pkgs.rebar3

            nodejs
            asyncapi
          ];
        };

      });
}

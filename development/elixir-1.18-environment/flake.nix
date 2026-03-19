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
						pkgs.pkg-config
            pkgs.gnumake
            pkgs.gcc
            pkgs.readline
						pkgs.srtp
            pkgs.openssl
            pkgs.zlib
            pkgs.libxml2
            pkgs.curl
            pkgs.libiconv
            pkgs.glibcLocales
            pkgs.postgresql
            pkgs.ctags
            pkgs.protobuf
						pkgs.clang-tools

            pkgs.erlang
            elixir
            elixir-ls
            pkgs.rebar3

            nodejs
            asyncapi
          ];
					shellHook = ''
            export ERL_INCLUDE_PATH="${pkgs.beam.packages.erlang_27.erlang}/lib/erlang/usr/include"

            export PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig:${pkgs.zlib.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"

            export CPATH="${pkgs.openssl.dev}/include:${pkgs.zlib.dev}/include:$CPATH"
            export LIBRARY_PATH="${pkgs.openssl.out}/lib:${pkgs.zlib.out}/lib:$LIBRARY_PATH"

            echo "Elixir/Nix Dev Environment Loaded"
          '';
        };

      });
}

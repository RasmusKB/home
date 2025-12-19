# https://github.com/NixOS/nixpkgs/pull/277180
{
  description = "Node development flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
				nodejs = pkgs.nodejs_25;

				jdk = pkgs.jdk21;

				openApiGenerator = pkgs.writeShellScriptBin "openapi-generator-cli" ''
					export JAVA_HOME=${jdk}
          ${nodejs}/bin/npx --yes @openapitools/openapi-generator-cli "$@"
        '';

				npxShim = pkgs.writeShellScriptBin "npx" ''
          if [ "$1" = "openapi-generator-cli" ]; then
            shift
            echo "⚡ [NIX FLAKE] Intercepting 'npx openapi-generator-cli' to use system Java..."
            exec ${openApiGenerator}/bin/openapi-generator-cli "$@"
          else
            exec ${nodejs}/bin/npx "$@"
          fi
        '';
				angular = pkgs.writeShellScriptBin "ng" ''
          ${nodejs}/bin/npx --yes @angular/cli@19.2.14 "$@"
        '';
				asyncapi = pkgs.writeShellScriptBin "asyncapi" ''
					${nodejs}/bin/npx --yes @asyncapi/cli "$@"
				'';
      in {

        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.gnumake
            pkgs.gcc
            pkgs.openssl
            pkgs.zlib
            pkgs.libxml2
            pkgs.curl
            pkgs.libiconv
						pkgs.tree
						jdk
						openApiGenerator
						npxShim
						nodejs
						angular
						asyncapi
          ];
					shellHook = ''
            export PATH=${npxShim}/bin:$PATH

            export JAVA_HOME=${jdk}
            echo "Environment loaded."
            echo "  - Java: 21 (Verified)"
            echo "  - NPX:  Shimmed to fix OpenApi Generator"
          '';
        };

      });
}

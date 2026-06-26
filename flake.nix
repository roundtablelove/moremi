{
  description = "Queen Moremi Ajasoro — Hugo site";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages.default = pkgs.stdenv.mkDerivation {
          name = "moremi-site";
          src = ./.;
          nativeBuildInputs = [ pkgs.hugo ];
          buildPhase = ''
            export HOME=$TMPDIR
            hugo --minify
          '';
          installPhase = "cp -r public $out";
        };

        devShells.default = pkgs.mkShell {
          packages = [ pkgs.hugo ];
        };
      }
    );
}

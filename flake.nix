{
  description = "Brian's Resume";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.flockenzeit.url = "github:balsoft/flockenzeit";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    flockenzeit,
  }: let
    # Generate a user-friendly version number.
    version = builtins.substring 0 8 self.lastModifiedDate;

    BUILD_DATE = with flockenzeit.lib.splitSecondsSinceEpoch {} self.lastModified; "${F}T${T}${Z}";
    VCS_REF = "${self.rev or "dirty"}";
  in
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config = {permittedInsecurePackages = ["openssl-1.1.1w"];};
      };
    in {
      packages.default = pkgs.stdenv.mkDerivation {
        name = "resume-${version}";
        src = ./.;
        buildInputs = with pkgs; [wkhtmltopdf-bin pandoc];
        buildPhase = ''
          echo "Document version: ${VCS_REF} ${BUILD_DATE}" > docs/version.mdpp
        '';
        installPhase = ''
          ./build
        '';
      };
      devShells.default =
        pkgs.mkShell {buildInputs = with pkgs; [wkhtmltopdf-bin pandoc];};
    });
}

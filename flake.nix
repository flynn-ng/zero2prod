{
  description = "Flake for rustup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell
          {
            nativeBuildInputs = with pkgs; [
              rustup
              pkg-config
              lld
            ];

            buildInputs = with pkgs; [
              openssl
              perl
            ];

            shellHook = ''
              export RUSTUP_HOME=$PWD/.rustup
              export CARGO_HOME=$PWD/.cargo
              export PATH="$CARGO_HOME/bin:$PATH"
            '';
          };
      }
    );
}

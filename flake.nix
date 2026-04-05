{
  inputs = {
    nixpkgs.url     = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.neovim
            pkgs.yazi
            pkgs.ripgrep
            pkgs.fd
            pkgs.fish
            pkgs.lsd
            pkgs.eza
            # pkgs.mysql
          ];

          shellHook = ''
            exec fish
          '';
        };
      }
    );
}

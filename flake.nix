{
  inputs = {
    nixpkgs.url     = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        tools = [
          pkgs.neovim
          pkgs.yazi
          pkgs.ripgrep
          pkgs.fd
          # pkgs.fish
          pkgs.lsd
          # pkgs.eza
          # pkgs.broot
          pkgs.dust
          pkgs.dua
          pkgs.xremap
        ];
      in {
        # `nix shell` - lightweight, just adds tools to PATH
        packages.default = pkgs.buildEnv {
          name = "my-env";
          paths = tools;
        };

        # `nix develop` - kept around for when you actually need a build env
        devShells.default = pkgs.mkShell {
          packages = tools;
          shellHook = ''
            exec fish
          '';
        };
      }
    );
}

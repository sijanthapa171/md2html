{
  description = "Elixir development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            beam.packages.erlang_26.elixir
            beam.packages.erlang_26.erlang
            inotify-tools 
          ];

          shellHook = ''
            echo "Elixir development environment loaded!"
            echo "Elixir version: $(elixir --version)"
          '';
        };
      });
} 
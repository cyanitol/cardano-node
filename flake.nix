{
  description = "Cardano Node";

  inputs = {
    haskell-nix.url = "github:input-output-hk/haskell.nix";
    nixpkgs.follows = "haskell-nix";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, haskell-nix, ... }:
    (utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ] (system:
      let
        cardano-node = import ./nix {
          inherit system;
          ownHaskellNix = haskell-nix.legacyPackages.${system};
          gitrev = self.rev;
        };
      in {
        legacyPackages = {inherit cardano-node; };
      }));
}

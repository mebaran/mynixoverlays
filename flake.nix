{
  description = "My Nix Overlays";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin"];
    forAllSystems = nixpkgs.lib.genAttrs systems;
    pkgsFor = forAllSystems (system:
      import nixpkgs {
        inherit system;
        overlays = [self.overlays.default];
      });
    callNpx = final: script: (final.callPackage ./packages/npx.nix {}).${script};
  in {
    overlays.default = final: prev: {
      goose-cli = final.callPackage ./packages/goose-cli.nix {};
      gemini-cli = callNpx final "gemini-cli";
      opencode = callNpx final "opencode";
      qwen-code = callNpx final "qwen-code";
    };

    packages = forAllSystems (system: {
      inherit (pkgsFor.${system}) goose-cli gemini-cli opencode qwen-code;
    });
  };
}

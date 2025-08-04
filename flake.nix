{
  description = "My Nix Overlays";

  outputs = { self, nixpkgs }: {
    overlays.default = final: prev: {
      # Import all packages from the ./packages directory
      # The `path` is relative to this flake.nix file
      # The `callPackage` function is used to import the .nix files
      # as packages.
      #
      # For more information on `callPackage`, see:
      # https://nixos.org/manual/nixpkgs/stable/#ssec-callpackage
      #
      # For more information on overlays, see:
      # https://nixos.wiki/wiki/Overlays
      #
      # For more information on flakes, see:
      # https://nixos.wiki/wiki/Flakes
      #
      # You can add more packages here by creating a new .nix file
      # in the ./packages directory and adding a new line here.
      #
      # For example, to add a package named `my-package`, you would
      # create a file named `my-package.nix` in the ./packages
      # directory and add the following line here:
      #
      #   my-package = final.callPackage ./packages/my-package.nix { };
      #
      goose-cli = final.callPackage ./packages/goose-cli.nix { };
      opencode = final.callPackage ./packages/opencode.nix { };
    };
  };
}

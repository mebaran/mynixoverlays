{pkgs, ...}: let
  npx = name: author: npmpkg:
    pkgs.writeShellApplication {
      name = name;
      runtimeInputs = [pkgs.bun];
      text = ''bunx @${author}/${npmpkg} "$@"'';
    };
in {
  opencode = npx "opencode" "sst" "opencode";
  gemini = npx "gemini" "google" "gemini-cli";
}

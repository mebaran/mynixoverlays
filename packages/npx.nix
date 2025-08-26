{pkgs, ...}: let
  npx = name: npmpkg:
    pkgs.writeShellApplication {
      name = name;
      runtimeInputs = [pkgs.bun];
      text = ''bunx ${npmpkg} "$@"'';
    };
in {
  opencode = npx "opencode" "opencode-ai@latest";
  gemini = npx "gemini" "@google/gemini-cli";
}

{pkgs, ...}:
pkgs.stdenv.mkDerivation rec {
  pname = "opencode";
  version = "0.3.126";

  src = pkgs.fetchzip {
    url = "https://github.com/sst/opencode/releases/download/v${version}/opencode-${{
        "x86_64-linux" = "linux-x64";
        "aarch64-linux" = "linux-arm64";
        "aarch64-darwin" = "darwin-arm64";
      }.${pkgs.system}}.zip";
    sha256 =
      {
        "x86_64-linux" = "05n3i6hlnzz882qwag0c7mnd997psn2ai550jz0w3y423xhwz5bm";
        "aarch64-linux" = "0h3n7gpq4hj4cdibkzl9y2fr03456dd4km5fb23f6z499pjlaa1y";
        "aarch64-darwin" = "1qcavbm909nrw4yligypaz47am6pjv7ndqrls8018iffrp1qsjk7";
      }.${pkgs.system};
    stripRoot = false;
  };

  dontFixup = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    install -Dm755 opencode $out/bin/opencode
    runHook postInstall
  '';

  meta = with pkgs.lib; {
    description = "Open-source AI coding agent by SST";
    homepage = "https://github.com/sst/opencode";
    license = licenses.mit;
    platforms = platforms.linux ++ platforms.darwin;
    maintainers = [];
  };
}

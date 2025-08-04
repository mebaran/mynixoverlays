{
  pkgs,
  ...
}:
pkgs.stdenv.mkDerivation rec {
  pname = "opencode";
  version = "0.3.113";

  src = pkgs.fetchzip {
    url = "https://github.com/sst/opencode/releases/download/v${version}/opencode-${{
      "x86_64-linux" = "linux-x64";
      "aarch64-linux" = "linux-arm64";
      "aarch64-darwin" = "darwin-arm64";
    }.${pkgs.system}}.zip";
    sha256 = {
      "x86_64-linux" = "sha256-8hL2Jd47l/FG0UuSWymc1HnXtqbRKt2pCtjp3/c/nsA=";
      "aarch64-linux" = "sha256-g5ABOLquhVmEOIGINOxaxYCyDB72O1uoPms7TbOtwb0=";
      "aarch64-darwin" = "sha256-O6gm6WH9W+I1/INZwvgF2uvjbwmSQNbdCeNpYUUm8Ic=";
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

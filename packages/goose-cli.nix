{pkgs, ...}:
pkgs.stdenv.mkDerivation rec {
  pname = "goose-cli";
  version = "1.8.0";

  src = pkgs.fetchzip {
    url = "https://github.com/block/goose/releases/download/v${version}/${
      {
        "x86_64-linux" = "goose-x86_64-unknown-linux-gnu.tar.bz2";
        "aarch64-linux" = "goose-aarch64-unknown-linux-gnu.tar.bz2";
        "aarch64-darwin" = "goose-aarch64-apple-darwin.tar.bz2";
        "x86_64-darwin" = "goose-x86_64-apple-darwin.tar.bz2";
      }.${
        pkgs.system
      }
    }";
    sha256 = {
      "x86_64-linux" = "sha256-XbEKAY4LAiEFBBNQYUHejYLcVClDMhvhPnygSPDXtgo=";
      "aarch64-linux" = "sha256-cXFNdBp/byZi9x/LOZCNiGgF4RmBW61kHRT5kgzMnfY=";
      "aarch64-darwin" = "sha256-kdfpHkyXfsViWDftkLKJS6bpmwppWL0QVDmY5GrAPwM=";
      "x86_64-darwin" = "sha256-pJShQsWGX/QUb3pInfOZiC8lDHD1blMgIp5cpF/f2Ok=";
    }.${
      pkgs.system
    };
    stripRoot = false;
  };

  nativeBuildInputs = pkgs.lib.optionals (!pkgs.stdenv.isDarwin) [pkgs.autoPatchelfHook];
  buildInputs = pkgs.lib.optionals (!pkgs.stdenv.isDarwin) [
    pkgs.stdenv.cc.cc.lib
    pkgs.xorg.libX11
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    install -Dm755 goose $out/bin/goose
    runHook postInstall
  '';

  meta = with pkgs.lib; {
    description = "Goose AI agent by Block";
    homepage = "https://github.com/block/goose";
    license = licenses.mit;
    platforms = platforms.linux ++ platforms.darwin;
    maintainers = [];
    mainProgram = "goose";
  };
}

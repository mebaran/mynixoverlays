{pkgs, ...}:
pkgs.stdenv.mkDerivation rec {
  pname = "goose-cli";
  version = "1.7.0";

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
      "x86_64-linux" = "sha256-rmibRzkdPWI2zvPknVy2FaRq7BIfoLC+w13EESuUlE8=";
      "aarch64-linux" = "sha256-AlajpIRuZg6G4CIWkvjF2XhESlhmu1qlxrdVUWSHklE=";
      "aarch64-darwin" = "sha256-8WAR40B/gdW3kFYl/UO/4v8ULUDqxS3SqLF1r736h6k=";
      "x86_64-darwin" = "sha256-2P8YDIVa4MB96Cv3EXvQOAvGJLsDrkk3aMS0dhMrtP8=";
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

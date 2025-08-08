{pkgs, ...}:
pkgs.stdenv.mkDerivation rec {
  pname = "goose-cli";
  version = "1.2.0";

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
    sha256 =
      {
        "x86_64-linux" = "sha256-Ps9+gwLb9V1OlDYTwK1cW7a7sodksXuKQbq7/GknKfo=";
        "aarch64-linux" = "sha256-6NTNH/wsO8hCqGqkU5c8+DvJGcJqPqZZdXvQr2lzvqk=";
        "aarch64-darwin" = "sha256-+myDPsgMKQo6IJFBznL20FCOXFOfdNW8LXM35PJ0Qwo=";
        "x86_64-darwin" = "sha256-bqE9SkzlqrSAZGz4obBNscKnCk3M5BO/2uuIxAuwEFg=";
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
  };
}

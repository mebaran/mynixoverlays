{pkgs, ...}:
pkgs.stdenv.mkDerivation rec {
  pname = "goose-cli";
  version = "1.4.0";

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
      "x86_64-linux" = "1as9srx93j5lhz2s1rybpw7mh1pnhqha7sr1q8bvp5zh9nafns8s";
      "aarch64-linux" = "0ydsvdpix0c48b8w6n1cpbnnwy506chv70s2ddrv8g1w5r39501i";
      "aarch64-darwin" = "131cwybsihwccm8d00k7scvmkbp6vlv0p4g7lpn6q9yws02hia30";
      "x86_64-darwin" = "0rwzppwgpyrhxcvi7mk6flph8w7bwbjqjlqbdicwj8ymsf41ns87";
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

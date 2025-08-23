{pkgs, ...}:
pkgs.stdenv.mkDerivation rec {
  pname = "goose-cli";
  version = "1.6.0";

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
      "x86_64-linux" = "1mmgnf0icwpfn5lyf21sahrldzqc9dvhaq4cx08l69alcwbljg86";
      "aarch64-linux" = "0wdmmv3rxz4xh1x2dz3zdi9x0b4p1x5i47frlh60cc4hdwv45l5j";
      "aarch64-darwin" = "05a2lxlg3chxq5a89prmpyxjmzkw5w62d5sy3qmzwp61n48aq4ky";
      "x86_64-darwin" = "11s84grc46q82syz3s9mnq4xdsa53c04mrxrp27dxk0b0zpcxsl4";
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

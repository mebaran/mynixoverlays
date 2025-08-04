{
  pkgs,
  ...
}:
pkgs.stdenv.mkDerivation rec {
  pname = "goose-cli";
  version = "1.1.4";

  src = pkgs.fetchzip {
    url = "https://github.com/block/goose/releases/download/v${version}/goose-${pkgs.system}.tar.bz2";
    sha256 = {
      "x86_64-linux" = "sha256-UNIdlDLJJ/phO+MrwUFG9IP5IYnszy6S2QpnfJItY54=";
      "aarch64-linux" = "sha256-o4OgSkGGGL6Euzc4i8XQjdkUOFFMze2UE3jG/RWoW8w=";
      "aarch64-darwin" = "sha256-OAQBRhQE45SARoz3faBzwBJVoQq7K4tfPK/pBsircL4=";
    }.${pkgs.system};
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

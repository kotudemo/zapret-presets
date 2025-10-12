{
  lib,
  patchelf,
  makeWrapper,
  stdenv,
  zapret,
  ...
}:

stdenv.mkDerivation {
  name = "secrets";
  version = "git";

  inherit (zapret) src; # yes, im genius

  nativeBuildInputs = [
    makeWrapper
    patchelf
  ];

  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;
  dontFixup = true;

  installPhase = ''
    runHook preInstall

    mkdir $out
    cp -r -a files/fake/* $out/

    runHook postInstall
  '';

  meta = {
    description = "binaries from zapret";
    homepage = "https://github.com/bol-van/zapret";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      kotudemo
      azikx
    ];
  };
}

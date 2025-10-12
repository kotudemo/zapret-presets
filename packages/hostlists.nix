{
  inputs,
  lib,
  patchelf,
  makeWrapper,
  stdenv,
  ...
}:

stdenv.mkDerivation {
  name = "hostlists";
  version = "git";

  src = inputs.hostlists;

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
    cp -r . $out/

    runHook postInstall
  '';

  meta = {
    description = "hostlists from zapret.cfgs";
    homepage = "https://github.com/Snowy-Fluffy/zapret.cfgs";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      kotudemo
      azikx
    ];
  };
}

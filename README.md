<div align="center"> <h1>
  【 󰜗 NIX ZAPRET FIXES 󰜗 】
</h1> </div>

adaptation [zapret.cfgs](https://github.com/Snowy-Fluffy/zapret.cfgs) for nixos

## Example configuration:

```nix
# flake.nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    zapret-presets.url = "github:kotudemo/zapret-presets";
  };

  outputs =
    inputs:
    let
      inherit (nixpkgs)
        lib
        ;
    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit
              inputs
              ;
            };

          modules = [
            inputs.zapret-presets.nixosModules.presets
            ...
          ];
        };
      };
    };
}
```

```nix
# ...
{
  services.zapret = {
    enable = true;

    sf_presets = {
      enable = true;

      preset = "renixos";
    };
  };
}
```

## Available presets:

```
  "general"
  "general_alt"
  "general_alt2"
  "general_alt3"
  "general_alt4"
  "general_alt5"
  "general_alt6"
  "general_mgts"
  "general_mgts2"

  "ultimatefix"
  "ultimatefix_alt"
  "ultimatefix_alt_extended"
  "ultimatefix_universal"
  "ultimatefix_universalv2"
  "ultimatefix_universalv3"
  "ultimatefix_mgts"

  "preset_russia"
  "russiafix"
  "renixos"
```

## **Special Thanks:**

[Snowy-Fluffy](https://github.com/Snowy-Fluffy)
[hand7s](https://github.com/s0me1newithhand7s)
[aca](https://github.com/aca/)

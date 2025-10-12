{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  secrets = pkgs.callPackage ../packages/secrets.nix { };
  hostlists = pkgs.callPackage ../packages/hostlists.nix {
    inherit
      inputs
      ;
  };

  cfg = config.services.zapret.sf_presets;
  blacklist =
    (map (host: "\"${host}\"") (
      splitString "\n" (fileContents "${hostlists}/lists/list-russia-blacklist.txt")
    ))
    ++ (map (host: "\"${host}\"") [
      "github.com"
      "reddit.com"
      "google.com"
    ]);
in

{
  options.services.zapret.sf_presets = {
    enable = mkEnableOption ''
      Enabling this option will allow you to activate GUI Software,
      that exist in my home-manager setup. Enabling this, as you can
      see, is depending on hostname of my system. To bypass this,
      either delete expression in `home.nix`, or change hostname
      to yours.
    '';

    preset = mkOption {
      type = types.enum [
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
      ];

      default = "general";

      description = ''
        Zapret option for using a presets created by community.
        You can choose between some of presets; careful -
        they might not work for your ISP since zapret is
        heavely ISP-dependent.
      '';
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      hostlists
      secrets
    ];

    services.zapret = {
      udpSupport = true;
      configureFirewall = true;

      udpPorts = [
        "50000:65535"
        "443"
      ];

      inherit
        blacklist
        ;

      params =
        optionals (cfg.preset == "general") [
          "--filter-udp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fake-quic=${secrets}/quic_initial_www_google_com.bin"
          "--new"

          "--filter-udp=50000-65535"
          "--dpi-desync=fake"
          "--dpi-desync-any-protocol"
          "--dpi-desync-cutoff=d3"
          "--dpi-desync-repeats=6"
          "--new"

          "--filter-tcp=80"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,split2"
          "--dpi-desync-autottl=2"
          "--dpi-desync-fooling=md5sig"
          "--new"

          "--filter-tcp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,split"
          "--dpi-desync-autottl=2"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fooling=badseq"
          "--dpi-desync-fake-tls=${secrets}/tls_clienthello_www_google_com.bin"
        ]
        ++ optionals (cfg.preset == "general_alt") [
          "--filter-udp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fake-quic=${secrets}/quic_initial_www_google_com.bin"
          "--new"

          "--filter-udp=50000-65535"
          "--dpi-desync=fake"
          "--dpi-desync-any-protocol"
          "--dpi-desync-cutoff=d3"
          "--dpi-desync-repeats=6"
          "--new"

          "--filter-tcp=80"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,split2"
          "--dpi-desync-autottl=2"
          "--dpi-desync-fooling=md5sig"
          "--new"

          "--filter-tcp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,split"
          "--dpi-desync-autottl=5"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fooling=badseq"
          "--dpi-desync-fake-tls=${secrets}/tls_clienthello_www_google_com.bin"
        ]
        ++ optionals (cfg.preset == "general_alt2") [
          "--filter-udp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fake-quic=${secrets}/quic_initial_www_google_com.bin"
          "--new"

          "--filter-udp=50000-65535"
          "--dpi-desync=fake"
          "--dpi-desync-any-protocol"
          "--dpi-desync-cutoff=d3"
          "--dpi-desync-repeats=6"
          "--new"

          "--filter-tcp=80"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,split2"
          "--dpi-desync-autottl=2"
          "--dpi-desync-fooling=md5sig"
          "--new"

          "--filter-tcp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=split2"
          "--dpi-desync-split-seqovl=652"
          "--dpi-desync-split-pos=2"
          "--dpi-desync-split-seqovl-pattern=${secrets}/tls_clienthello_www_google_com.bin"
        ]
        ++ optionals (cfg.preset == "general_alt3") [
          "--filter-udp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fake-quic=${secrets}/quic_initial_www_google_com.bin"
          "--new"

          "--filter-udp=50000-65535"
          "--dpi-desync=fake"
          "--dpi-desync-any-protocol"
          "--dpi-desync-cutoff=d3"
          "--dpi-desync-repeats=6"
          "--new"

          "--filter-tcp=80"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,split2"
          "--dpi-desync-autottl=2"
          "--dpi-desync-fooling=md5sig"
          "--new"

          "--filter-tcp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=split"
          "--dpi-desync-split-pos=1"
          "--dpi-desync-autottl"
          "--dpi-desync-fooling=badseq"
          "--dpi-desync-repeats=8"
        ]
        ++ optionals (cfg.preset == "general_alt4") [
          "--filter-udp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fake-quic=${secrets}/quic_initial_www_google_com.bin"
          "--new"

          "--filter-udp=50000-65535"
          "--dpi-desync=fake"
          "--dpi-desync-any-protocol"
          "--dpi-desync-cutoff=d3"
          "--dpi-desync-repeats=8"
          "--new"

          "--filter-tcp=80"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,split2"
          "--dpi-desync-autottl=2"
          "--dpi-desync-fooling=md5sig"
          "--new"

          "--filter-tcp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,split2"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fooling=md5sig"
          "--dpi-desync-fake-tls=${secrets}/tls_clienthello_www_google_com.bin"
        ]
        ++ optionals (cfg.preset == "general_alt5") [
          "--filter-udp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fake-quic=${secrets}/quic_initial_www_google_com.bin"
          "--new"

          "--filter-udp=50000-65535"
          "--dpi-desync=fake"
          "--dpi-desync-any-protocol"
          "--dpi-desync-cutoff=d3"
          "--dpi-desync-repeats=6"
          "--new"

          "--filter-tcp=80"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,split2"
          "--dpi-desync-autottl=2"
          "--dpi-desync-fooling=md5sig"
          "--new"
        ]
        ++ optionals (cfg.preset == "general_alt6") [
          "--filter-udp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fake-quic=${secrets}/quic_initial_www_google_com.bin"
          "--new"

          "--filter-udp=50000-50100"
          "--hostlist=${hostlists}/lists/ipset-discord.txt"
          "--dpi-desync=fake"
          "--dpi-desync-any-protocol"
          "--dpi-desync-cutoff=d3"
          "--dpi-desync-repeats=6"
          "--new"

          "--filter-tcp=80"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,split2"
          "--dpi-desync-autottl=2"
          "--dpi-desync-fooling=md5sig"
          "--new"

          "--filter-tcp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,split"
          "--dpi-desync-autottl=2"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fooling=badseq"
          "--dpi-desync-fake-tls=${secrets}/tls_clienthello_www_google_com.bin"
        ]
        ++ optionals (cfg.preset == "general_mgts") [
          "--filter-udp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fake-quic=${secrets}/quic_initial_www_google_com.bin"
          "--new"

          "--filter-udp=50000-65535"
          "--dpi-desync=fake"
          "--dpi-desync-any-protocol"
          "--dpi-desync-cutoff=d3"
          "--dpi-desync-repeats=6"
          "--new"

          "--filter-tcp=80"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,split2"
          "--dpi-desync-autottl=2"
          "--dpi-desync-fooling=md5sig"
          "--new"

          "--filter-tcp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake"
          "--dpi-desync-autottl=2"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fooling=badseq"
          "--dpi-desync-fake-tls=${secrets}/tls_clienthello_www_google_com.bin"
        ]
        ++ optionals (cfg.preset == "general_mgts2") [
          "--filter-udp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fake-quic=${secrets}/quic_initial_www_google_com.bin"
          "--new"

          "--filter-udp=50000-65535"
          "--dpi-desync=fake"
          "--dpi-desync-any-protocol"
          "--dpi-desync-cutoff=d3"
          "--dpi-desync-repeats=6"
          "--new"

          "--filter-tcp=80"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,split2"
          "--dpi-desync-autottl=2"
          "--dpi-desync-fooling=md5sig"
          "--new"

          "--filter-tcp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fooling=md5sig"
          "--dpi-desync-fake-tls=${secrets}/tls_clienthello_www_google_com.bin"
        ]
        ++ optionals (cfg.preset == "ultimatefix") [
          "--filter-udp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fake-quic=${secrets}/quic_initial_www_google_com.bin"
          "--new"

          "--filter-udp=50000-65535"
          "--hostlist=${hostlists}/lists/ipset-discord.txt"
          "--dpi-desync=fake"
          "--dpi-desync-any-protocol"
          "--dpi-desync-cutoff=d3"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fake-quic=${secrets}/quic_initial_www_google_com.bin"
          "--new"

          "--filter-tcp=80"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,split2"
          "--dpi-desync-autottl=2"
          "--dpi-desync-fooling=md5sig"
          "--new"

          "--filter-tcp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,split"
          "--dpi-desync-autottl=2"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fooling=badseq"
          "--dpi-desync-fake-tls=${secrets}/tls_clienthello_www_google_com.bin"
        ]
        ++ optionals (cfg.preset == "ultimatefix_alt") [
          "--filter-udp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fake-quic=${secrets}/quic_initial_www_google_com.bin"
          "--new"

          "--filter-udp=50000-65535"
          "--hostlist=${hostlists}/lists/ipset-discord.txt"
          "--dpi-desync=fake"
          "--dpi-desync-any-protocol"
          "--dpi-desync-cutoff=d3"
          "--dpi-desync-repeats=6"
          "--new"

          "--filter-tcp=80"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,split2"
          "--dpi-desync-autottl=2"
          "--dpi-desync-fooling=md5sig"
          "--new"

          "--filter-tcp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,split"
          "--dpi-desync-autottl=5"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fooling=md5sig"
          "--dpi-desync-fake-tls=${secrets}/tls_clienthello_www_google_com.bin"
        ]
        ++ optionals (cfg.preset == "ultimatefix_alt_extended") [
          "--filter-udp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake"
          "--dpi-desync-repeats=6"
          "--dpi-desync-udplen-increment=10"
          "--dpi-desync-udplen-pattern=0xDEADBEEF"
          "--dpi-desync-fake-quic=${secrets}/quic_initial_www_google_com.bin"
          "--new"

          "--filter-udp=50000-65535"
          "--hostlist=${hostlists}/lists/ipset-discord.txt"
          "--dpi-desync=fake"
          "--dpi-desync-any-protocol"
          "--dpi-desync-cutoff=d3"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fake-quic=${secrets}/quic_initial_www_google_com.bin"
          "--new"

          "--filter-tcp=80"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,split2"
          "--dpi-desync-autottl=2"
          "--dpi-desync-fooling=md5sig"
          "--new"

          "--filter-tcp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,split"
          "--dpi-desync-autottl=2"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fooling=badseq"
          "--dpi-desync-fake-tls=${secrets}/tls_clienthello_www_google_com.bin"
        ]
        ++ optionals (cfg.preset == "ultimatefix_mgts") [
          "--filter-udp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fake-quic=${secrets}/quic_initial_www_google_com.bin"
          "--new"

          "--filter-udp=50000-65535"
          "--hostlist=\"/opt/zapret/ipset/ipset-discord.txt\""
          "--dpi-desync=fake"
          "--dpi-desync-any-protocol"
          "--dpi-desync-cutoff=d3"
          "--dpi-desync-repeats=6"
          "--new"

          "--filter-tcp=80"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,split2"
          "--dpi-desync-autottl=2"
          "--dpi-desync-fooling=md5sig"
          "--new"

          "--filter-tcp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake"
          "--dpi-desync-autottl=2"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fooling=badseq"
          "--dpi-desync-fake-tls=${secrets}/tls_clienthello_www_google_com.bin"
        ]
        ++ optionals (cfg.preset == "ultimatefix_universal") [
          "--filter-udp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fake-quic=${secrets}/quic_initial_www_google_com.bin"
          "--new"

          "--filter-udp=50000-65535"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake"
          "--dpi-desync-any-protocol"
          "--dpi-desync-cutoff=d3"
          "--dpi-desync-repeats=6"
          "--new"

          "--filter-tcp=80"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,split2"
          "--dpi-desync-autottl=2"
          "--dpi-desync-fooling=md5sig"
          "--new"

          "--filter-tcp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,split2"
          "--dpi-desync-autottl=2"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fooling=badseq"
          "--dpi-desync-fake-tls=${secrets}/tls_clienthello_www_google_com.bin"
          "--dpi-desync-split-pos=1"
        ]
        ++ optionals (cfg.preset == "ultimatefix_universalv2") [
          "--filter-udp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,disorder2"
          "--dpi-desync-repeats=8"
          "--dpi-desync-udplen-increment=12"
          "--dpi-desync-udplen-pattern=0xDEADBEEF"
          "--dpi-desync-fake-quic=${secrets}/quic_initial_www_google_com.bin"
          "--new"

          "--filter-udp=50000-65535"
          "--hostlist=${hostlists}/lists/ipset-discord.txt"
          "--dpi-desync=fake,tamper"
          "--dpi-desync-any-protocol"
          "--dpi-desync-cutoff=d4"
          "--dpi-desync-repeats=8"
          "--new"

          "--filter-tcp=80"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,split2"
          "--dpi-desync-autottl=3"
          "--dpi-desync-fooling=md5sig"
          "--new"

          "--filter-tcp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=disorder2"
          "--dpi-desync-split-pos=2"
          "--dpi-desync-autottl=3"
          "--dpi-desync-repeats=8"
          "--dpi-desync-fooling=badseq"
          "--dpi-desync-fake-tls=${secrets}/tls_clienthello_www_google_com.bin"
        ]
        ++ optionals (cfg.preset == "ultimatefix_universalv3") [
          "--filter-udp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,split2"
          "--dpi-desync-repeats=10"
          "--dpi-desync-udplen-increment=15"
          "--dpi-desync-udplen-pattern=0xCAFEBABE"
          "--dpi-desync-fake-quic=${secrets}/quic_initial_www_google_com.bin"
          "--new"

          "--filter-udp=50000-65535"
          "--hostlist=${hostlists}/lists/ipset-discord.txt"
          "--dpi-desync=fake,disorder2"
          "--dpi-desync-any-protocol"
          "--dpi-desync-cutoff=n5"
          "--dpi-desync-repeats=10"
          "--new"

          "--filter-tcp=80"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,disorder2"
          "--dpi-desync-autottl=4"
          "--dpi-desync-fooling=badseq"
          "--new"

          "--filter-tcp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=split"
          "--dpi-desync-split-pos=3"
          "--dpi-desync-autottl=4"
          "--dpi-desync-repeats=10"
          "--dpi-desync-fooling=md5sig"
          "--dpi-desync-fake-tls=${secrets}/tls_clienthello_www_google_com.bin"
        ]
        ++ optionals (cfg.preset == "preset_russia") [
          "--filter-tcp=80"
          "--dpi-desync=fake,split2"
          "--dpi-desync-autottl=2"
          "--dpi-desync-fooling=md5sig"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--new"

          "--filter-tcp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,split2"
          "--dpi-desync-repeats=11"
          "--dpi-desync-fooling=md5sig"
          "--dpi-desync-fake-tls=${secrets}/tls_clienthello_www_google_com.bin"
          "--new"

          "--filter-tcp=80,443"
          "--dpi-desync=fake,disorder2"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync-autottl=2"
          "--dpi-desync-fooling=md5sig"
          "--new"

          "--filter-udp=50000-50100"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake"
          "--dpi-desync-repeats=6"
          "--dpi-desync-any-protocol"
          "--dpi-desync-cutoff=n4"
          "--new"

          "--filter-udp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake"
          "--dpi-desync-repeats=11"
          "--dpi-desync-fake-quic=${secrets}/quic_initial_www_google_com.bin"
          "--new"

          "--filter-udp=443"
          "--dpi-desync=fake"
          "--dpi-desync-repeats=11"
        ]
        ++ optionals (cfg.preset == "russiafix") [
          "--filter-tcp=80"
          "--dpi-desync=fake,split2"
          "--dpi-desync-autottl=2"
          "--dpi-desync-fooling=md5sig"
          # "--hostlist-auto=${hostlists}/lists/autohostlist.txt"

          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--new"

          "--filter-tcp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake,split2"
          "--dpi-desync-repeats=11"
          "--dpi-desync-fooling=md5sig"
          "--dpi-desync-fake-tls=${secrets}/tls_clienthello_www_google_com.bin"
          "--new"

          "--filter-tcp=80,443"
          "--dpi-desync=fake,disorder2"
          "--dpi-desync-autottl=2"
          "--dpi-desync-fooling=md5sig"
          "--new"

          "--filter-udp=50000-50099"
          "--hostlist=${hostlists}/lists/ipset-discord.txt"
          "--dpi-desync=fake"
          "--dpi-desync-repeats=6"
          "--dpi-desync-any-protocol"
          "--dpi-desync-cutoff=n4"
          "--new"

          "--filter-udp=443"
          "--hostlist=${hostlists}/lists/list-basic.txt"
          "--dpi-desync=fake"
          "--dpi-desync-repeats=11"
          "--dpi-desync-fake-quic=${secrets}/quic_initial_www_google_com.bin"
          "--new"

          "--filter-udp=443"
          "--dpi-desync=fake"
          "--dpi-desync-repeats=11"
        ]
        ++ optionals (cfg.preset == "renixos") [
          "--wssize 1:6"

          "--filter-tcp=80"
          "--dpi-desync=multisplit"
          "--dpi-desync-split-pos=10"
          "--dpi-desync-repeats=6"
          "--new"

          "--filter-tcp=443"
          "--dpi-desync=multidisorder"
          "--dpi-desync-split-pos=1,midsld"
          "--new"

          "--filter-tcp=443"
          "--dpi-desync=syndata"
          "--dpi-desync-fake-syndata=0x00000000"
          "--dpi-desync-ttl=10"
          "--new"

          "--filter-udp=443"
          "--dpi-desync=fake"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fake-quic=0x00000000"
          "--new"

          "--filter-udp=443"
          "--dpi-desync=fake,udplen"
          "--dpi-desync-udplen-increment=5"
          "--dpi-desync-fake-tls=0x00000000"
          "--dpi-desync-cutoff=n3"
          "--dpi-desync-repeats=2"
          "--new"

          "--filter-tcp=443"
          "--dpi-desync=split"
          "--dpi-desync-fooling=md5sig,badseq"
          "--dpi-desync-fake-tls=0x00000000"
          "--dpi-desync-split-pos=1"
          "--dpi-desync-repeats=10"
          "--new"

          "--filter-tcp=443"
          "--dpi-desync=fake,split2"
          "--dpi-desync-fooling=md5sig"
          "--dpi-desync-fake-tls=0x00000000"
          "--dpi-desync-split-seqovl=2"
          "--dpi-desync-split-pos=2"

          "--dpi-desync-autottl"
          "--new"
          "--filter-tcp=443"
          "--dpi-desync=fake,split2"
          "--dpi-desync-fooling=md5sig"
          "--dpi-desync-fake-tls=0x00000000"
          "--dpi-desync-split-seqovl=2"
          "--dpi-desync-split-pos=2"
          "--dpi-desync-autottl"
          "--new"

          "--filter-tcp=80"
          "--dpi-desync=fake,split2"
          "--dpi-desync-fooling=md5sig"
          "--dpi-desync-fake-tls=0x00000000"
          "--dpi-desync-autottl"
          "--new"

          "--filter-tcp=80"
          "--dpi-desync-ttl=1"
          "--dpi-desync-autottl=2"
          "--dpi-desync-fake-tls=0x00000000"
          "--dpi-desync-split-pos=1"
          "--dpi-desync=fake,split2"
          "--dpi-desync-repeats=6"
          "--dpi-desync-fooling=md5sig"
          "--new"
        ];
    };
  };
}

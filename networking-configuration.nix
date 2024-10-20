{ config, pkgs, ... }:

let
  privateZeroTierInterfaces = [
    "ztr2qxf559" # vpn
  ];
in

{
  # Networking set-up
  networking = {
    hostId = "141ec2b6"; # cut -c-8 </proc/sys/kernel/random/uuid
    hostName = "T101"; # Define your hostname.
    domain = "wcbrpar.com"; # cut -c-8 </proc/sys/kernel/random/uuid
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  # networking.useDHCP = true;
    interfaces.enp1s0.useDHCP = false;
    interfaces.wlp2s0.useDHCP = true;
    interfaces.ztr2qxf559.ipv4.addresses = [{
      address = "192.168.13.3";
      prefixLength = 28;
    }];
    nameservers = [ "84.200.69.80" "84.200.70.40" ]; # CloudFlare / DNS Watch
  
    # Network hosts
    extraHosts = ''
      127.0.0.1      localhost
      192.168.13.10  pegasus.wcbrpar.com
      192.168.13.20  galactica.wcbrpar.com
    '';

    firewall.enable = false;
    firewall.trustedInterfaces = privateZeroTierInterfaces;
    networkmanager.enable = false;
    networkmanager.wifi.powersave = true;

    wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    wireless.interfaces = [ "wlp2s0" ];
    wireless.userControlled.enable = true;
    wireless.userControlled.group = "wheel";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  };
  # mDNS
  services.avahi.enable = true;
  services.avahi.allowInterfaces = privateZeroTierInterfaces;
  services.avahi.nssmdns4 = true;
  services.avahi.publish.addresses = true;
  services.avahi.publish.domain = true;
  services.avahi.publish.enable = true;
  services.avahi.publish.userServices = true;
  services.avahi.publish.workstation = true;

  # ZEROTIER
  services.zerotierone.enable = true;
  services.zerotierone.joinNetworks = [
    "abfd31bd47447701" # vpn                (PRIVATE)
  ];

  # Create AP when in cabled connection
  services.create_ap = {
    enable = true;
    settings = {
      INTERNET_IFACE = "enp3s0f3u4";
      WIFI_IFACE = "wlp2s0";
      SSID = "RED Spot";
      PASSPHRASE = "redcom.digital";
    };
  };

  # Wi-fi corporate network set-up
  networking.wireless.networks = {
    "walCOR Seguros" = {         # SSID with spaces and/or special characters
    pskRaw = "8800e2ad89df3154f75d1f2b7945588309b9ccde7b2761389f599f2f0674c489";
    };
    "RED COM" = {         
    pskRaw = "faa45d7d01498ac974c436b709d77c0d3b93563c7ab8082ba2debe171d3fb0e8";
    };
    "Château Queiroz" = {              # Chateau dês Queiroz
    pskRaw = "5a6c4ccc7aa2e252314e60a6d43cfb385130bc0b9755741bd0cb779b5f413b42";
    };
    "Château Queiroz-5G" = {           # Chateau dês Queiroz
    pskRaw = "89f345f6c8b7730c2b8477432d777e2e8ee289f1d31befa880f594e1246aa37a";
    };
    "Chac Sol Nascente" = {
    pskRaw = "ae4ab90ec346ba9c835fb3ad775f9bff245cf97ab91d9d99d93fb2e203cdc270";
    };
    "ADM-PT" = {
    pskRaw = "0f90c28c0fd0c55ac4ab4cd622c7e6c4600fb5fe7fc7a10ca1d2b17ad013493d";
    };
    "PTMS" = {
    pskRaw = "e975ec3bb41571d40b6e0559cd76520aac9a9397128a3f9c679ad3cc6ece4c3a";
    };
    "CUT MS" = {
    pskRaw = "ed6c2b1e8358a879985f30c78a7ece7c793068a3459a6b6b5181fe0a245ee169";
    };
  #  "WIFI AUDITORIO FETEMS"={
  #  pskRaw = "45979a4385f39ff9ec4745b255e139114e0150162fac6ba79e25eaded78e8353";
  #  };
    "2G Digital Sintsep" = {
    pskRaw = "b34dad265dca881555a1d278d4b6fc4ea77b6a1948bd070e81735bbda94b58d7";
    }; 
    "5G Digital Sintsep" = {
    pskRaw = "f8046f9b3d518ab85990a07bb583d996b0d17cfdb949af67ddfc0ecc6d567fd3";
    }; 
    "ENFF PUBLICA" = {
    #psk="lutar-construir-reformaagraria-popular"
    pskRaw = "dd25da5429f155440c0b2932ac99e6a46889273c1383dfcb6521c7dc636ce5c2";
    };
    "IBIS BUDGET" = {
    };
    "eduroam" = {
    # identity = "walter.queiroz";
    # domain_suffix_match = "ufms.br";
    # key_mgmt = WPA-EAP;
    # eap = PEAP; 
    # ca_cert = "/etc/ssl/certs/ca-bundle.crt" ;
    # phase2 = "auth=MSCHAPV2";
    # password = "hash:dfc1345fba0e5126f1c6b141160ae353";
    };
  };

}



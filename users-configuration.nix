{ config, lib, options, modulesPath, users, pkgs, environment, ... }: 
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  security.sudo.wheelNeedsPassword = false;
  users.users.wjjunyor = {
    isNormalUser = true;
    createHome = true;
    home = "/W/Shared/WJR/";
    description = "Walter Queiroz";
    uid = 1000;
    group = "users";
    extraGroups = [ "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal" "adbusers" "scanner" "lp"  ];
    useDefaultShell = true;
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDlE3hqwUhIDnitfyYhU2LnulduhSYl9XJDCf/XrV8LL5hkSt6HSj0WEh1Pn1AJyW5C77WMB+BcmviakKTNlwijVYIu64S24lJjfB60SN/XzzEoQiloXrTGSqhokz9J8Usj3VIMeNLV3lyFiv0nX4ZiPrcBeDzK8a5Cxrf17POiwQjRjrRoVxZ8iNOu8Oo0hEFvhqnuuPDbwnE+dJ4tpwSnyBSweeMRYXKBf1SLK4E3TeLPXxhzKvuTZhnzXLHJ6qx3WKWjkPI6gE9cjFn5sopsWq2ZWXkJTs2+ePdQJinG9IY+D5wKwOLTPNZhuvpwinHvXV9IhBlhHukm8X3i82h6644slX9pcMYC4zrk+etz4Idko51PySLf7hKElXpD7E6PhnY5LyMvaeol9Lqpz8v1Ar1TGJtmdTG9O39w4kvE4QoSQL/Z1zNdchmvglt/AW9m0YuoG3K29QNWBHPnDdlKHcXA+viuwxdU7TotYzjqGwWzG6JwLqsAPn626YNW4XU= wjjunyor@T101" ];
  };
  
  users.users.caroles = {
    isNormalUser = true;
    createHome = true;
    home = "/home/caroles";
    description = "Carolina Queiroz";
    uid = 2000;
    group = "users";
    extraGroups = [ "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal" "adbusers" ];
    useDefaultShell = true;
  };

  users.users."bruno.queiroz" = {
    isNormalUser = true;
    createHome = true;
    home = "/home/BSQ";
    description = "Bruno Queiroz";
    uid = 3000;
    group = "users";
    extraGroups = [ "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal" "adbusers" ];
    useDefaultShell = true;
  };

  users.users."rafaela.queiroz" = {
    isNormalUser = true;
    createHome = true;
    home = "/home/RSQ";
    description = "Rafaela Queiroz";
    uid = 4000;
    group = "users";
    extraGroups = [ "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal" "adbusers" ];
    useDefaultShell = true;
  };

}

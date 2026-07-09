{ unstable, ... }: { 
  virtualisation.docker.enable = true;

  users.users.soundwave.extraGroups = [ "docker" ];

  environment.systemPackages = [ 
    unstable.docker-compose
    unstable.docker
  ];
}

{ ... }:

{
  virtualisation.docker.enable = true;

  virtualisation.oci-containers = {
    backend = "docker";
    containers.convertx = {
      image = "ghcr.io/c4illin/convertx:latest";
      
      ports = [ "3522:3000" ];
      volumes = [ "/var/lib/convertx:/app/data" ];

      autoStart = false;

      environment = {
        ALLOW_UNAUTHENTICATED = "true";
        HTTP_ALLOWED = "true";
      };
    };
  };

  # Псевдонимы для терминала
  environment.shellAliases = {
    convertx = "sudo systemctl start docker-convertx && sleep 4 && firefox http://localhost:3522";
    convertx-stop = "sudo systemctl stop docker-convertx";
  };
}

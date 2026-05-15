{
  disko.devices = {
    disk = {
      # Имя диска в системе(в скрипте мы передадим реальное имя, например /dev/nvme0n1)
      main = {
        type = "disk";
        device = ""; # Оставляем пустым, Disko заполнит это через аргументы командной строки
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00"; # Тип раздела EFI
              size = "512M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "defaults" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}

{ stable, ... }: {
  # Установка дополнений для работы гостя(звук, буфер обмена, драйверы)
  home.packages = with stable; [
    virt-viewer      # Просмотрщик консоли ВМ высокой производительности
    spice-gtk        # Передача звука, USB и буфера обмена с хоста
    virtio-win       # ISO с быстрыми драйверами диска/сети для Windows
  ];

  # Преднастройка интерфейса: убираем ручные клики при первом запуске
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}

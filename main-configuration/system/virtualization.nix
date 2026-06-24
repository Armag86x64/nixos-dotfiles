{ stable, ... }: {
  # Включение демона libvirtd для управления KVM/QEMU
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = stable.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true; # Эмулятор чипа безопасности, нужен для установки винды, шифрования дисков и Secure Boot
    };
  };

  # Добавление пользователя в группу libvirtd (необходимо для управления ВМ)
  users.users.soundwave = {
    extraGroups = [ "libvirtd" "kvm" ];
  };
}

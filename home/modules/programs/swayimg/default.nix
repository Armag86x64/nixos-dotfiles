{ unstable, ... }: {
  programs.swayimg = {
    enable = true;
    package = unstable.swayimg;
  };

  xdg.configFile."swayimg/init.lua".text = ''
    -- Подгружать остальные картинки из той же папки
    swayimg.imagelist.enable_adjacent(true)

    -- Режим просмотра (Viewer)
    swayimg.viewer.on_key("j", function()
      swayimg.viewer.switch_image("next")
    end)
    swayimg.viewer.on_key("k", function()
      swayimg.viewer.switch_image("prev")
    end)
    swayimg.viewer.on_key("q", function()
      swayimg.exit()
    end)

    -- Режим галереи (Gallery)
    swayimg.gallery.on_key("j", function()
      swayimg.gallery.switch_image("next")
    end)
    swayimg.gallery.on_key("k", function()
      swayimg.gallery.switch_image("prev")
    end)
    swayimg.gallery.on_key("q", function()
      swayimg.exit()
    end)
  '';
}

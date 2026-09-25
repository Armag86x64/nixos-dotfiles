{ ... }: {
  home.file.".config/cosmic/com.system76.CosmicComp/v1/xkb_config" = {
    text = ''
      (
        rules: "",
        model: "",
        layout: "us,ru",
        variant: "",
        options: Some("grp:alt_shift_toggle"),
      )
    '';
    force = true;
  };
}

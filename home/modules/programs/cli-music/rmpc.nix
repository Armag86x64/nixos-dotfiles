{ config, pkgs, ... }:

{
  programs.rmpc = {
    enable = true;
    config = ''
      #![enable(implicit_some)]
      #![enable(unwrap_newtypes)]
      #![enable(unwrap_variant_newtypes)]
      (
        address: "127.0.0.1:6600",
        theme: "radar-mint",
        enable_mouse: true,
        enable_config_hot_reload: true,
        status_update_interval_ms: 1000,
        volume_step: 5,
        max_fps: 60,
        scrolloff: 2,
        wrap_navigation: true,
      )
    '';
  };

  xdg.configFile."rmpc/themes/radar-mint.ron".text = ''
    #![enable(implicit_some)]
    #![enable(unwrap_newtypes)]
    #![enable(unwrap_variant_newtypes)]
    (
      default_album_art_path: None,
      show_song_table_header: true,
      draw_borders: true,
      browser_column_widths: [20, 38, 42],

      // Палитра в стиле референса: глубокий графит + мятный неон
      background_color: "#000000",
      text_color: "#e6eceb",
      header_background_color: "#111515",
      modal_background_color: "#131717",
      modal_backdrop: true,

      preview_label_style: (fg: "#40d19e", modifiers: "Bold"),
      preview_metadata_group_style: (fg: "#75807e", modifiers: "Bold"),

      tab_bar: (
        enabled: true,
        active_style: (fg: "#0b0e0e", bg: "#40d19e", modifiers: "Bold"),
        inactive_style: (fg: "#75807e", bg: "#131717"),
      ),

      highlighted_item_style: (fg: "#40d19e", modifiers: "Bold"),
      current_item_style: (fg: "#0b0e0e", bg: "#40d19e", modifiers: "Bold"),

      // Тонкие тёмно-зелёные/серые рамки, как сетка в таблице на скриншоте
      borders_style: (fg: "#1e2524"),
      highlight_border_style: (fg: "#40d19e"),

      symbols: (
        song: "♪",
        dir: "▸",
        playlist: "≡",
        marker: "● ",
        ellipsis: "…",
      ),

      progress_bar: (
        symbols: ["━", "●", "─"],
        track_style: (fg: "#1e2524"),
        elapsed_style: (fg: "#40d19e"),
        thumb_style: (fg: "#40d19e", bg: "#0b0e0e"),
      ),

      scrollbar: (
        symbols: ["│", "█", "▲", "▼"],
        track_style: (fg: "#131717"),
        ends_style: (fg: "#2a3332"),
        thumb_style: (fg: "#40d19e"),
      ),

      // Колонки таблицы треков в духе колонок NAME / TIME / PRICE / GRAPH
      song_table_format: [
        (
          prop: (kind: Property(Artist), default: (kind: Text("Unknown"))),
          width: "25%",
          label: "ARTIST",
          style: (fg: "#75807e"),
        ),
        (
          prop: (kind: Property(Title), default: (kind: Text("Unknown"))),
          width: "40%",
          label: "TRACK",
          style: (fg: "#e6eceb", modifiers: "Bold"),
        ),
        (
          prop: (kind: Property(Album), default: (kind: Text("Unknown Album"))),
          width: "25%",
          label: "ALBUM",
          style: (fg: "#75807e"),
        ),
        (
          prop: (kind: Property(Duration), default: (kind: Text("-"))),
          width: "10%",
          alignment: Right,
          label: "TIME",
          style: (fg: "#40d19e"),
        ),
      ],

      header: (
        rows: [
          (
            left: [
              (kind: Text(" ◉ "), style: (fg: "#40d19e", modifiers: "Bold")),
              (kind: Property(Status(StateV2(
                playing_label: "ACTIVE",
                paused_label: "PAUSED",
                stopped_label: "STOPPED",
              ))), style: (fg: "#40d19e", modifiers: "Bold")),
            ],
            center: [
              (kind: Property(Song(Title)), style: (fg: "#e6eceb", modifiers: "Bold"),
                default: (kind: Text("No Track Selected"), style: (fg: "#75807e", modifiers: "Bold"))
              ),
            ],
            right: [
              (kind: Text("VOL "), style: (fg: "#75807e")),
              (kind: Property(Status(Volume)), style: (fg: "#40d19e", modifiers: "Bold")),
              (kind: Text("% "), style: (fg: "#40d19e")),
            ],
          ),
          (
            left: [
              (kind: Text(" "), style: (fg: "#75807e")),
              (kind: Property(Status(Elapsed)), style: (fg: "#e6eceb")),
              (kind: Text(" / "), style: (fg: "#75807e")),
              (kind: Property(Status(Duration)), style: (fg: "#75807e")),
              (kind: Text(" • "), style: (fg: "#2a3332")),
              (kind: Property(Status(Bitrate)), style: (fg: "#40d19e")),
              (kind: Text(" kbps"), style: (fg: "#75807e")),
            ],
            center: [
              (kind: Property(Song(Artist)), style: (fg: "#40d19e"),
                default: (kind: Text("Unknown Artist"), style: (fg: "#75807e"))
              ),
              (kind: Text(" — "), style: (fg: "#2a3332")),
              (kind: Property(Song(Album)), style: (fg: "#75807e"),
                default: (kind: Text("Unknown Album"), style: (fg: "#75807e"))
              ),
            ],
            right: [
              (kind: Property(Status(RepeatV2(
                on_label: "RPT ",
                off_label: "RPT ",
                on_style: (fg: "#40d19e", modifiers: "Bold"),
                off_style: (fg: "#2a3332"),
              )))),
              (kind: Property(Status(RandomV2(
                on_label: "RND ",
                off_label: "RND ",
                on_style: (fg: "#40d19e", modifiers: "Bold"),
                off_style: (fg: "#2a3332"),
              )))),
              (kind: Property(Status(SingleV2(
                on_label: "SGL ",
                off_label: "SGL ",
                on_style: (fg: "#40d19e", modifiers: "Bold"),
                off_style: (fg: "#2a3332"),
              )))),
            ],
          ),
        ],
      ),

      // Градиент для встроенного эквалайзера Cava (как мини-графики справа на скриншоте)
      cava: (
        bar_symbols: ['▁', '▂', '▃', '▄', '▅', '▆', '▇', '█'],
        inverted_bar_symbols: ['▔', '🮂', '🮃', '▀', '🮄', '🮅', '🮆', '█'],
        bg_color: "#0b0e0e",
        bar_width: 2,
        bar_spacing: 1,
        orientation: Bottom,
        bar_color: Gradient({
          0:   "#1b4d3e",
          50:  "#2e9975",
          100: "#40d19e",
        }),
      ),
    )
  '';
}

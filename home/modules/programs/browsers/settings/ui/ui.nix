# common-ui.nix
{ config, lib, ... }:
let
  customUserContent = ''
    @-moz-document url("about:newtab"), url("about:home") {
      .logo-and-wordmark .wordmark,
      .logo-and-wordmark .logo {
        display: none !important;
      }

      .logo-and-wordmark {
        background-image: url("file://${./images/main_logo_2.png}") !important;
        background-size: contain !important;
        background-position: center !important;
        background-repeat: no-repeat !important;
        width: 200px !important;
        height: 82px !important;
        margin-left: auto !important;
        margin-right: auto !important;
      }

      body, #newtab-customize-overlay {
        background-color: #000000 !important;
      }

      button.search-handoff-button,
      .search-wrapper .search-handoff-button,
      .search-inner-wrapper {
        background-color: #121214 !important;
        border: 1px solid #1a1a1c !important;
        box-shadow: none !important;
        border-radius: 24px !important; 
      }

      .search-wrapper input:focus,
      .search-inner-wrapper:focus-within {
        background-color: #000000 !important;
        box-shadow: none !important;
      }

      .top-sites, .top-sites-list, #topSites {
        display: none !important;
      }
    }
  '';
in
{
  programs.firefox.profiles.soundwave.userContent = lib.mkIf config.programs.firefox.enable customUserContent;

  programs.librewolf.profiles.soundwave.userContent = lib.mkIf config.programs.librewolf.enable customUserContent;
}

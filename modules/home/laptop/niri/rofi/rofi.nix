{ pkgs, config, ... }: {
  programs.rofi = {
    enable  = true;
    package = pkgs.rofi;
    extraConfig = {
      modi               = "drun,run";
      show-icons         = true;
      icon-theme         = "Papirus";
      font               = "JetBrainsMono Nerd Font Mono 12";
      drun-display-format = "{icon} {name}";
      display-drun       = " Apps";
      display-run        = " Run";
    };
    theme =
      let inherit (config.lib.formats.rasi) mkLiteral;
      in {
        "*" = {
          bg           = mkLiteral "#1e1e2e";
          bg-alt       = mkLiteral "#1e1e2eCC";
          foreground   = mkLiteral "#313244";
          selected     = mkLiteral "#cba6f7";
          active       = mkLiteral "#a6e3a1";
          text-selected = mkLiteral "#1e1e2e";
          text-color   = mkLiteral "#cdd6f4";
          border-color = mkLiteral "#cba6f7";
          urgent       = mkLiteral "#f38ba8";
        };
        "window" = {
          transparency      = "real";
          width             = mkLiteral "500px";
          location          = mkLiteral "center";
          anchor            = mkLiteral "center";
          fullscreen        = false;
          x-offset          = mkLiteral "0px";
          y-offset          = mkLiteral "0px";
          cursor            = "default";
          enabled           = true;
          border-radius     = mkLiteral "12px";
          background-color  = mkLiteral "#1e1e2eD9";
        };
        "mainbox" = {
          enabled          = true;
          spacing          = mkLiteral "20px";
          padding          = mkLiteral "20px";
          orientation      = mkLiteral "vertical";
          children         = map mkLiteral [ "inputbar" "listview" "mode-switcher" ];
          background-color = mkLiteral "transparent";
        };
        "inputbar" = {
          enabled          = true;
          spacing          = mkLiteral "10px";
          padding          = mkLiteral "10px";
          border-radius    = mkLiteral "8px";
          background-color = mkLiteral "@bg-alt";
          text-color       = mkLiteral "@text-color";
          children         = map mkLiteral [ "textbox-prompt-colon" "entry" ];
        };
        "textbox-prompt-colon" = {
          enabled          = true;
          expand           = false;
          str              = "";
          background-color = mkLiteral "inherit";
          text-color       = mkLiteral "@selected";
        };
        "entry" = {
          enabled          = true;
          background-color = mkLiteral "inherit";
          text-color       = mkLiteral "inherit";
          cursor           = mkLiteral "text";
          placeholder      = "Search";
          placeholder-color = mkLiteral "inherit";
        };
        "mode-switcher" = {
          enabled          = true;
          spacing          = mkLiteral "10px";
          background-color = mkLiteral "transparent";
          text-color       = mkLiteral "@text-color";
          orientation      = mkLiteral "horizontal";
        };
        "button" = {
          padding          = mkLiteral "10px 20px";
          border-radius    = mkLiteral "8px";
          background-color = mkLiteral "@bg-alt";
          text-color       = mkLiteral "inherit";
          cursor           = mkLiteral "pointer";
          horizontal-align = mkLiteral "0.5";
        };
        "button selected" = {
          background-color = mkLiteral "@selected";
          text-color       = mkLiteral "@text-selected";
        };
        "listview" = {
          enabled         = true;
          columns         = 1;
          lines           = 5;
          cycle           = true;
          dynamic         = true;
          scrollbar       = false;
          layout          = mkLiteral "vertical";
          spacing         = mkLiteral "8px";
          background-color = mkLiteral "transparent";
          text-color      = mkLiteral "@text-color";
        };
        "element" = {
          enabled          = true;
          spacing          = mkLiteral "12px";
          padding          = mkLiteral "8px 10px";
          border-radius    = mkLiteral "8px";
          background-color = mkLiteral "transparent";
          text-color       = mkLiteral "@text-color";
          cursor           = mkLiteral "pointer";
        };
        "element selected.normal" = {
          background-color = mkLiteral "@selected";
          text-color       = mkLiteral "@text-selected";
        };
        "element normal.urgent" = {
          background-color = mkLiteral "@urgent";
          text-color       = mkLiteral "@text-color";
        };
        "element-icon" = {
          background-color = mkLiteral "transparent";
          text-color       = mkLiteral "inherit";
          size             = mkLiteral "32px";
          cursor           = mkLiteral "inherit";
        };
        "element-text" = {
          background-color = mkLiteral "transparent";
          text-color       = mkLiteral "inherit";
          cursor           = mkLiteral "inherit";
          vertical-align   = mkLiteral "0.5";
          horizontal-align = mkLiteral "0.0";
        };
        "error-message" = {
          padding          = mkLiteral "15px";
          border-radius    = mkLiteral "12px";
          background-color = mkLiteral "@bg";
          text-color       = mkLiteral "@text-color";
        };
      };
  };
}

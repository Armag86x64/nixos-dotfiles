{ ... }: {
  /* C E N T E R */
  programs.waybar.settings.mainBar = {

    /* L E F T  -  H A R D W A R E */

    /* "custom/void-center" = {
      format = " ";
      min-length = 5;
    }; */

    cpu = {
      interval = 10;
      format = "CPU: {usage}% / {load}";
      format-warning = "CPU: {usage}%";
      format-critical = "CPU: {usage}%";
      states = {
        warning = 75;
        critical = 90;
      };
      tooltip = false;
      min-length = 15;
      max-length = 15;

    };

    temperature = {
      thermal-zone = 3;
      interval = 5;
      critical-threshold = 70;
      format-critical = "{temperatureC}°C";
      format = "{temperatureC}°C";
      min-length = 8;
    };


    disk = {
      interval = 30;
      format = "({path}): {free}";
      unit = "GB";
      path = "/";
      min-length = 15;
    };

    memory = {
      interval = 10;
      format = "RAM: {used} GB";
      format-warning = "RAM: {used} GB";
      format-critical = "RAM: {used} GB";
      states = {
        warning = 75;
        critical = 90;
      };
      tooltip-format = "Memory Used: {used:0.1f} GB / {total:0.1f} GB";
      min-length = 15;
      max-length = 15;      
    };


    /* L O G O */

    "custom/logo" = {
      format = "▽ "; # ▼
      min-length = 4;
      on-click = "wofi --show drun";
    };


    /* R I G H T  -  N E T W O R K*/


    network = {
      interface = "wlp0s20f3";
      format = "{ifname}";
      format-wifi = "WiFi: {essid}/{ipaddr} ({signalStrength}%)";
      format-ethernet = "Ethernet: {ipaddr}/{cidr} ";
      format-disconnected = "Disconnected";
      tooltip-format = "{ifname} via {gwaddr} ";
      tooltip-format-wifi = "{essid} ({signalStrength}%) ";
      tooltip-format-ethernet = "{ifname} ";
      tooltip-format-disconnected = "Disconnected";

      max-length = 70;
      min-length = 30;
    };

    bluetooth = {
	    format = "blue: {status}";
	    format-connected = "blue: {device_alias}";
	    format-connected-battery = " {device_alias} {device_battery_percentage}%";
	    # "format-device-preference": [ "device1", "device2" ], // preference list deciding the displayed device
	    tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
	    tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
	    tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
	    tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";

      max-length = 30;
      min-length = 20;
    };

  };
}

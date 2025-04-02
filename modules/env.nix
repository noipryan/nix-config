# configure environmen vars
{ config, lib, ... }:

{

  # set some environment variables
  environment.variables = lib.mkForce {
      QT_QPA_PLATFORMTHEME = "qt5ct";
    };
  
  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state/";
  };
}

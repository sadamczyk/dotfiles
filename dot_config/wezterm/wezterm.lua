local wezterm = require 'wezterm';

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  default_prog = {"wsl.exe", "--exec", "/usr/bin/fish"}
else
  default_prog = {"/usr/local/bin/fish"}
end

return {
  color_scheme = "Solarized Darcula",
  exit_behavior = "Close", -- remove after new release, "CloseOnCleanExit" is the default!
  default_prog = default_prog,
}

-- Add this option when new release comes out!
--  clean_exit_codes = {130}, -- allows ^D after ^C in zsh without annoying message


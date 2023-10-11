-- Set nice hotkeys up with this! https://wezfurlong.org/wezterm/config/keys.html#leader-key

local wezterm = require 'wezterm';

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  default_prog = {"wsl.exe", "--exec", "/usr/bin/fish"}
else
  default_prog = {"fish"}
end

-- Automatically switch colorscheme based on OS appearance
-- https://wezfurlong.org/wezterm/config/lua/window/get_appearance.html
function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return "Solarized (dark) (terminal.sexy)"
  else
    return "Solarized (light) (terminal.sexy)"
  end
end

wezterm.on("window-config-reloaded", function(window, pane)
  local overrides = window:get_config_overrides() or {}
  local appearance = window:get_appearance()
  local scheme = scheme_for_appearance(appearance)
  if overrides.color_scheme ~= scheme then
    overrides.color_scheme = scheme
    window:set_config_overrides(overrides)
  end
end)

return {
  default_prog = default_prog,
  exit_behavior = "Close", -- remove after new release, "CloseOnCleanExit" is the default!
  font_size = 11,
  font = wezterm.font 'DejaVu Sans Mono',
  -- harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }, -- Disables ligatures, yuck. TODO: Is this needed? I think DejaVu Sans Mono doesn't support them anyway.
  initial_cols = 500,
  initial_rows = 500,
  window_close_confirmation = "NeverPrompt",
  keys = {
    {key="w", mods="CTRL|SHIFT", action=wezterm.action{CloseCurrentTab={confirm=false}}}, -- don't confirm closing tabs
  },
}

-- Add this option when new release comes out!
--  clean_exit_codes = {130}, -- allows ^D after ^C (exit code >0 from last command) in zsh without annoying message

local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback({
	"PragmataPro Mono",
})
config.font_size = 16
config.line_height = 1.2

config.keys = {
	{
		key = "p",
		mods = "CMD|SHIFT",
		action = wezterm.action.ActivateCommandPalette,
	},
	-- Claude Code CLI를 위한 키바인딩 (Ghostty 설정에서 이관)
	{
		key = "Enter",
		mods = "SHIFT",
		action = wezterm.action.SendString("\x1b\r"),
	},
}

-- 한글 출력 문제
config.normalize_output_to_unicode_nfc = true

-- 성능
config.max_fps = 120 -- 최대 FPS를 120으로 설정 (기본값: 60)
config.prefer_egl = true -- EGL 렌더링 API 선호 (성능/호환성 향상)

---------------------------------------------------------------------------------
-- 모양
---------------------------------------------------------------------------------
config.color_scheme = "Catppuccin Frappe"

-- macOS 타이틀바 숨김 (Ghostty 설정에서 이관)
config.window_decorations = "RESIZE"

-- 상단 탭바 비활성화
config.enable_tab_bar = false

-- tmux 전체 화면 활용을 위한 패딩 제거
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.macos_window_background_blur = 40
config.window_background_opacity = 0.9 -- 투명도 조절 필요

wezterm.on("augment-command-palette", function()
	return {
		{
			brief = "Toggle transparency",
			icon = "md_circle_opacity",
			action = wezterm.action_callback(function(window)
				local overrides = window:get_config_overrides() or {}
				if not overrides.window_background_opacity or overrides.window_background_opacity == 1 then
					overrides.window_background_opacity = 0.85
				else
					overrides.window_background_opacity = 1
				end
				window:set_config_overrides(overrides)
			end),
		},
	}
end)

return config

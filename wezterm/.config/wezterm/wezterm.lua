local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback({
	"PragmataPro Mono",
	{ family = "Symbols Nerd Font Mono", scale = 1.0 },
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
-- 한글 입력 문제
config.use_ime = true

-- 성능
config.max_fps = 120 -- 최대 FPS를 120으로 설정 (기본값: 60)
config.prefer_egl = true -- EGL 렌더링 API 선호 (성능/호환성 향상)

---------------------------------------------------------------------------------
-- 모양
---------------------------------------------------------------------------------
-- herdr 테마(catppuccin)와 배경색을 맞춘다.
-- herdr는 pane 본문·사이드바 비선택 행 등을 SGR 49(배경 기본값)로 그려서
-- 호스트 터미널 배경이 그대로 노출된다. 따라서 herdr 배경을 바꾸려면
-- herdr의 panel_bg 가 아니라 이쪽 배경색을 맞춰야 한다.
config.color_scheme = "Catppuccin Mocha"

-- 배경만 mantle(#181825)로 낮춘다. Mocha 기본 배경은 base(#1e1e2e)인데,
-- herdr가 사이드바의 "현재 위치" 강조에 쓰는 색이 바로 base 다.
-- 배경을 base로 두면 강조 행과 배경이 같은 색이 되어 강조가 사라진다.
config.colors = { background = "#181825" }

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

return config

module window

import ui

pub struct DebuggerWindow{
	window &ui.Window
}

pub fn new_debugger() &DebuggerWindow{
	w := ui.window(
		title: "v-boy - gameboy emulator - debugger"
	)

	return &DebuggerWindow{
		window: w
	}
}

pub fn(d &DebuggerWindow) open_main() {
		ui.run(d.window)
}


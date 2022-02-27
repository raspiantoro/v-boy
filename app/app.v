module app

import gui.window
import emu

struct App {
mut:
	window &window.MainWindow
	machine &emu.Machine
}

pub fn new() &App{
	m := emu.new_machine()
	w := window.new(500, 300, m)
	a := &App{
		window: w
		machine: m
	}

	return a
}

pub fn(a &App) start(){
	a.window.open_main()
}

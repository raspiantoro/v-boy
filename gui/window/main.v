module window

import ui
import gx
import emu

[heap]
pub struct MainWindow{
mut:
	window &ui.Window = unsafe{0}
	machine &emu.Machine
}


pub fn new(width int, height int, machine &emu.Machine) &MainWindow{
	mut mw :=  &MainWindow{
		machine: machine
	}

	w := mw.setup_layout(width, height)
	mw.window = w

	return mw
}

fn(m &MainWindow) setup_layout(width int, height int) &ui.Window{
	w := ui.window(
		title: "v-boy - gameboy emulator"
		width: width
    	height: height
		mode: .resizable
		on_init: win_init
		children: [
			ui.row(
				widths: [ui.compact, ui.stretch] // 350.0]
				heights: [ui.compact, ui.stretch] // 300.0]
				children: [
					ui.canvas_layout(
						id: "top_area"
						on_draw: draw_top
						full_width: width
						children: [
							ui.at(0,0, ui.menu(
								id: 'file_menu'
								text: 'File'
								width: 50
								items: [
									ui.menuitem(
										text: 'File'
										action: fn (item &ui.MenuItem) {
											mut fpm := item.menu.ui.window.menu('file_pop_menu')
											mut vpm := item.menu.ui.window.menu('view_pop_menu')
											fpm.set_pos(0, 30)
											fpm.offset_y = 0
											fpm.hidden = !fpm.hidden
											vpm.hidden = true
										}
									),
								]
							)),
							ui.at(0,30, ui.menu(
								id: 'file_pop_menu'
								width: 300
								items: [
									ui.menuitem(
										text: 'Open ROM'
										action: m.open_rom_click
									),
									ui.menuitem(
										text: 'Exit'
										action: fn (item &ui.MenuItem) {
											unsafe{
												item.menu.ui.window.close()
											}					
										}
									)
								]
							)),
							ui.at(50,0, ui.menu(
								id: 'view_menu'
								text: 'View'
								width: 50
								items: [
									ui.menuitem(
										text: 'View'
										action: fn (item &ui.MenuItem) {
											mut fpm := item.menu.ui.window.menu('file_pop_menu')
											mut vpm := item.menu.ui.window.menu('view_pop_menu')
											vpm.set_pos(50,30)
											vpm.offset_x = 1
											vpm.offset_y = 0
											vpm.hidden = !vpm.hidden
											fpm.hidden = true
										}
									)
								]
							)),
							ui.at(50,30, ui.menu(
								id: 'view_pop_menu'
								width: 150
								items: [
									&ui.MenuItem{
										text: 'Debugger'
									}
								]
							))
						]
					),
				]
			),
		]
	)

	return w
}

pub fn(m &MainWindow) open_main() {
	ui.run(m.window)
}

fn draw_top(d ui.DrawDevice, c &ui.CanvasLayout) {
	w, h := c.full_width, 30
	c.draw_device_rect_filled(d, 0, 0, w, h, gx.white)
}

pub fn(mut m MainWindow) open_rom_click(mut item &ui.MenuItem){
	if item.text == "Open ROM" {
		item.text = "Close ROM"
		mut fpm := item.menu.ui.window.menu('file_pop_menu')
		mut vpm := item.menu.ui.window.menu('view_pop_menu')
		fpm.set_pos(0, 30)
		fpm.offset_y = 0
		fpm.hidden = !fpm.hidden
		vpm.hidden = true

		gs := new_game_screen()	
		m.machine.screen = gs 
		go m.machine.run()
		
	} else {
		item.text = "Open ROM"
		m.machine.screen.close()
		m.machine.reset_screen()
	}
	
}

fn win_init(mut w ui.Window) {
	mut fpm := w.menu('file_pop_menu')
	mut vpm := w.menu('view_pop_menu')
	fpm.set_visible(false)
	vpm.set_visible(false)
}
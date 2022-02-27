module window

import sdl
import config

pub struct GameScreen{
mut:
	pixels [][]u8
	window &sdl.Window = unsafe{0}
	renderer &sdl.Renderer = unsafe{0}
}

fn new_game_screen() GameScreen{
	return GameScreen{
		pixels: [][]u8{len: config.pixel_height, init: []u8{len: config.pixel_width}}
	}
}

fn (mut s GameScreen) open(){
	println("Hello game screen")

	sdl.init(sdl.init_video)
	window := sdl.create_window('Hello SDL2'.str, 300, 300, 500, 300, 0)
	renderer := sdl.create_renderer(window, -1, u32(sdl.RendererFlags.accelerated) | u32(sdl.RendererFlags.presentvsync))

	s.window = window
	s.renderer = renderer

	mut should_close := false
	for {
		evt := sdl.Event{}
		for 0 < sdl.poll_event(&evt) {
			match evt.@type {
				.quit { should_close = true }
				else {}
			}
		}
		if should_close {
			break
		}

		sdl.set_render_draw_color(renderer, 255, 55, 55, 255)
		sdl.render_clear(renderer)
		sdl.render_present(renderer)
	}

	
}

fn (mut s GameScreen) close(){
	sdl.destroy_renderer(s.renderer)
	sdl.destroy_window(s.window)
	sdl.quit()
}

fn (mut s GameScreen) render(){
	
}
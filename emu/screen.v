module emu

interface Screen{
	pixels [][]u8
mut:
	open()
	render()
	close()
}

struct DummyScreen{
	pixels [][]u8
}

pub fn(s &DummyScreen) render(){}
pub fn(s &DummyScreen) open(){}
pub fn(s &DummyScreen) close(){}
module emu

[heap]
pub struct Machine{
pub mut:
	screen Screen
}

pub fn new_machine() &Machine{
	return &Machine{
		screen: &DummyScreen{}
	}
}

pub fn(mut m Machine) run(){
	m.screen.open()
}

pub fn(mut m Machine) reset_screen(){
	m.screen = &DummyScreen{}
}
extends Usable

func useObject(): 
	MainEventBus.animation_fade_in_to_object.emit(self);

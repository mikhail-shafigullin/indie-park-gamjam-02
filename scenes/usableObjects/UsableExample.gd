extends Usable

@onready var colorRect: ColorRect = %ColorRect; 

func useObject(): 
	colorRect.color = Color.AQUA;
	pass;

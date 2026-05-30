extends Usable

var isFirstTime: bool = true;
@onready var paperSprite: Sprite2D = $Sprite2D;

func useObject():
	if(isFirstTime):
		Dialogic.start("BathroomMirror", "mirrorUseWithNewspaperClip");
		MainEventBus.inventory_add_item.emit(BathroomNewspaper.new());
		paperSprite.visible = false;
		isFirstTime = false
	else:
		Dialogic.start("BathroomMirror", "mirrorUseWithoutNewspaperClip");

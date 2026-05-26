extends Level

@onready var bedSprite: AnimatedSprite2D = $BedSprite;
@onready var startMarker: Marker2D = $Start;

func _ready() -> void:
	bedSprite.play()

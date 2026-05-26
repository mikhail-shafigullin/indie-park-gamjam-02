extends Usable

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D;
@onready var teleportMarker: Marker2D = $"../Marker2D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animatedSprite.play()
	pass # Replace with function body.


func useObject():
	MainEventBus.send_player_to_marker.emit(teleportMarker);

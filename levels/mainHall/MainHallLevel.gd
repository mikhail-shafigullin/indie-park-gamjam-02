extends Level

@onready var markerStartGame: Marker2D = %MarkerStartGame;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MainEventBus.send_player_to_marker.emit(markerStartGame);
	pass;

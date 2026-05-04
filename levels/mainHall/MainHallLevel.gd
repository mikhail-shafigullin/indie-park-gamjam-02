extends Node2D

@onready var markerStartGame: Marker2D = %MarkerStartGame;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print('asda')
	MainEventBus.send_player_to_marker.emit(markerStartGame);
	pass;

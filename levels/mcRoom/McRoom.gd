extends Level

@onready var starterMarker: Marker2D = %StarterMarker;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MainEventBus.send_player_to_marker.emit(starterMarker);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

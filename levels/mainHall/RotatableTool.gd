extends Node2D

@export_enum("down", "left", "up", "right") var direction: int;

@onready var rotatableComponent: RotatableComponent = %RotatableComponent


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotatableComponent.rotateTo(direction);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

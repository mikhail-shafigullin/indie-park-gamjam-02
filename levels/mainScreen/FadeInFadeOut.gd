extends Control

const FADE_DURATION = 0.5

@onready var curtain: ColorRect = %Curtain

func _ready() -> void:
	MainEventBus.animation_fade_in_to_object.connect(fadeIn)
	MainEventBus.animation_fade_out_from_object.connect(fadeOut)

func fadeIn(obj: Node2D) -> void:
	var tween := create_tween()
	tween.tween_property(curtain, "color:a", 1.0, FADE_DURATION)
	tween.finished.connect( func(): MainEventBus.animation_fade_out_from_object.emit(obj))

func fadeOut(_obj: Node2D) -> void:
	var tween := create_tween()
	tween.tween_property(curtain, "color:a", 0.0, FADE_DURATION)

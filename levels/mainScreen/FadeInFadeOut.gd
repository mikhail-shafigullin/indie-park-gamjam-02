class_name FadeInFadeOut
extends Control

const FADE_DURATION = 0.5

@onready var curtain: ColorRect = %Curtain

signal animation_fade_in_to_object(obj: Node2D);
signal animation_fade_in_finished();
signal animation_fade_out_from_object(obj: Node2D);
signal animation_fade_out_finished();

func _ready() -> void:
	animation_fade_in_to_object.connect(fadeIn)
	animation_fade_out_from_object.connect(fadeOut)

func fadeIn(obj: Node2D) -> void:
	var tween := create_tween()
	tween.tween_property(curtain, "color:a", 1.0, FADE_DURATION)
	tween.finished.connect( func(): animation_fade_in_finished.emit())

func fadeOut(_obj: Node2D) -> void:
	var tween := create_tween()
	tween.tween_property(curtain, "color:a", 0.0, FADE_DURATION)
	tween.finished.connect( func(): animation_fade_out_finished.emit())

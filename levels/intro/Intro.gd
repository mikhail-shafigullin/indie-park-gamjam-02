class_name IntroScreen
extends Node2D

#res://levels/mainScreen/MainScreen.tscn
const game_res := preload("uid://dfq6e4l7o4y8o")

func _ready() -> void:
	Global.intro_screen = self
	Dialogic.start("intro")


func start_the_game() -> void:
	get_parent().add_child(game_res.instantiate())
	queue_free()

func sleep() -> void:
	%Anim.play("sleep")

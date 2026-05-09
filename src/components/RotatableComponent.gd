class_name RotatableComponent
extends Node

@export var animatedSprite: AnimatedSprite2D
@export var collisionShape: CollisionShape2D

const DIRECTIONS = ["direction_down", "direction_left", "direction_up", "direction_right"]

var directionIndex: int = 0

func rotate() -> void:
	directionIndex = (directionIndex + 1) % DIRECTIONS.size()
	if animatedSprite:
		animatedSprite.play(DIRECTIONS[directionIndex])
	if collisionShape:
		collisionShape.rotation_degrees += 90.0

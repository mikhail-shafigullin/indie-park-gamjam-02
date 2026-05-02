extends Node2D

const SPEED := 130.0

enum State { IDLE, WALK }

var state := State.IDLE
var last_direction := Vector2.DOWN

@onready var sprite: AnimatedSprite2D = %AnimatedSprite2D

func _process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if direction != Vector2.ZERO:
		state = State.WALK
		last_direction = direction
		position += direction * SPEED * delta
	else:
		state = State.IDLE

	_update_animation()

func _update_animation() -> void:
	var prefix := "walk_" if state == State.WALK else "idle_"
	sprite.play(prefix + _direction_name())

func _direction_name() -> String:
	if abs(last_direction.x) > abs(last_direction.y):
		return "right" if last_direction.x > 0 else "left"
	else:
		return "down" if last_direction.y > 0 else "up"

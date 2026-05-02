extends CharacterBody2D

const SPEED := 130.0
const INTERACT_DISTANCE := 37.0

enum State { IDLE, WALK }

var state := State.IDLE
var lastDirection := Vector2.DOWN
var lastInteractTarget: Node = null

@onready var sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var rayCast: RayCast2D = %RayCast

func _process(_delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if direction != Vector2.ZERO:
		direction = direction.normalized();
		state = State.WALK
		lastDirection = direction
		velocity = direction * SPEED
	else:
		state = State.IDLE
		velocity = Vector2.ZERO

	move_and_slide()
	updateAnimation()
	updateRaycast()
	checkRaycast()

	if Input.is_action_just_pressed("use") and lastInteractTarget and lastInteractTarget.collision_layer & 4:
		useObject(lastInteractTarget)

func updateAnimation() -> void:
	var prefix := "walk_" if state == State.WALK else "idle_"
	sprite.play(prefix + directionName())

func directionName() -> String:
	if abs(lastDirection.x) > abs(lastDirection.y):
		return "right" if lastDirection.x > 0 else "left"
	else:
		return "down" if lastDirection.y > 0 else "up"

func updateRaycast() -> void:
	rayCast.target_position = lastDirection.normalized() * INTERACT_DISTANCE

func checkRaycast() -> void:
	var collider = rayCast.get_collider() if rayCast.is_colliding() else null
	if collider == lastInteractTarget:
		return
	var prevTarget := lastInteractTarget
	lastInteractTarget = collider
	checkRaycastUsable(prevTarget, collider)
	checkRaycastGrabable(prevTarget, collider)

func checkRaycastUsable(prevTarget: Node, collider: Node) -> void:
	if prevTarget and prevTarget.collision_layer & 4:
		unhoverUsableObject(prevTarget)
	if collider and collider.collision_layer & 4:
		hoverUsableObject(collider)

func checkRaycastGrabable(prevTarget: Node, collider: Node) -> void:
	if prevTarget and prevTarget.collision_layer & 8:
		unhoverGrabableObject(prevTarget)
	if collider and collider.collision_layer & 8:
		hoverGrabableObject(collider)

func hoverUsableObject(collider: Node2D) -> void:
	MainEventBus.usable_object_is_hovered.emit(collider)

func unhoverUsableObject(collider: Node2D) -> void:
	MainEventBus.usable_object_is_unhovered.emit(collider)

func hoverGrabableObject(collider: Node2D) -> void:
	MainEventBus.grabable_object_is_hovered.emit(collider)

func unhoverGrabableObject(collider: Node2D) -> void:
	MainEventBus.grabable_object_is_unhovered.emit(collider)

func useObject(collider: Node2D) -> void:
	var usableObject: Usable = collider.get_parent();
	usableObject.useObject();

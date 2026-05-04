class_name PlayerController
extends CharacterBody2D

const SPEED = 130.0
const INTERACT_DISTANCE = 37.0
const GRAB_MULTIPLICATOR = 0.7

enum State { IDLE, WALK }

var state = State.IDLE
var lastDirection = Vector2.DOWN
var lastInteractTarget: Node = null

var grabbedBody: StaticBody2D = null
var grabbedNode: Grabable = null
var grabOffset: Vector2 = Vector2.ZERO
var grabExtraCollision: CollisionShape2D = null
var animationDirection = Vector2.DOWN
var controlsEnabled = true

@onready var sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var rayCast: RayCast2D = %RayCast

func _init() -> void:
	MainEventBus.send_player_to_marker.connect(teleportToMarker);

func _ready() -> void:
	MainEventBus.image_layer_show_image.connect(disableControls)
	MainEventBus.image_layer_hidden.connect(enableControls)

func disableControls(_image: Texture2D) -> void:
	controlsEnabled = false
	velocity = Vector2.ZERO
	state = State.IDLE

func enableControls() -> void:
	controlsEnabled = true

func _process(_delta: float) -> void:
	if not controlsEnabled:
		move_and_slide()
		updateAnimation()
		return

	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if direction != Vector2.ZERO:
		direction = direction.normalized()
		state = State.WALK
		lastDirection = direction
		velocity = direction * SPEED 
		if grabbedNode:
			velocity = velocity * GRAB_MULTIPLICATOR;
	else:
		state = State.IDLE
		velocity = Vector2.ZERO

	move_and_slide()
	updateGrabbedPosition()
	updateAnimation()
	updateRaycast()
	checkRaycast()

	if Input.is_action_just_pressed("use") and lastInteractTarget and lastInteractTarget.collision_layer & 4:
		useObject(lastInteractTarget)

	if Input.is_action_just_pressed("grab"):
		if grabbedBody:
			releaseObject()
		elif lastInteractTarget and lastInteractTarget.collision_layer & 8:
			grabObject(lastInteractTarget)

func updateGrabbedPosition() -> void:
	if not grabbedNode:
		return
	grabbedNode.global_position = global_position + grabOffset

func updateAnimation() -> void:
	# if smth is grabbed we don't change animation direction
	if not grabbedNode:
		animationDirection = lastDirection;

	var prefix := "walk_" if state == State.WALK else "idle_"
	sprite.play(prefix + directionName())

func directionName() -> String:
	if abs(animationDirection.x) > abs(animationDirection.y):
		return "right" if animationDirection.x > 0 else "left"
	else:
		return "down" if animationDirection.y > 0 else "up"

func updateRaycast() -> void:
	rayCast.target_position = animationDirection.normalized() * INTERACT_DISTANCE

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
	if prevTarget and prevTarget.collision_layer & 8 and prevTarget != grabbedBody:
		unhoverGrabableObject(prevTarget)
	if collider and collider.collision_layer & 8 and collider != grabbedBody:
		hoverGrabableObject(collider)

func hoverUsableObject(collider: Node2D) -> void:
	MainEventBus.usable_object_is_hovered.emit(collider)

func unhoverUsableObject(collider: Node2D) -> void:
	MainEventBus.usable_object_is_unhovered.emit(collider)

func hoverGrabableObject(collider: Node2D) -> void:
	MainEventBus.grabable_object_is_hovered.emit(collider)

func unhoverGrabableObject(collider: Node2D) -> void:
	MainEventBus.grabable_object_is_unhovered.emit(collider)

func grabObject(collider: Node) -> void:
	var parent := collider.get_parent()
	if not parent is Grabable:
		return
	grabbedBody = collider as StaticBody2D
	grabbedNode = parent as Grabable
	grabOffset = grabbedNode.global_position - global_position
	add_collision_exception_with(grabbedBody)
	var shapeNode: CollisionShape2D = grabbedBody.get_node("CollisionShape2D")
	grabExtraCollision = CollisionShape2D.new()
	grabExtraCollision.shape = shapeNode.shape
	grabExtraCollision.position = to_local(shapeNode.global_position)
	add_child(grabExtraCollision)
	grabbedNode.onGrab()

func releaseObject() -> void:
	grabbedNode.onRelease()
	remove_collision_exception_with(grabbedBody)
	grabExtraCollision.queue_free()
	grabExtraCollision = null
	grabbedBody = null
	grabbedNode = null

func useObject(collider: Node2D) -> void:
	var usableObject: Usable = collider.get_parent()
	usableObject.useObject()
	
func teleportToMarker(marker: Marker2D):
	reparent(marker.get_parent())
	position = marker.position;
	

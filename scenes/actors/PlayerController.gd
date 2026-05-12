class_name PlayerController
extends CharacterBody2D

const SPEED = 130.0
const INTERACT_DISTANCE = 20.0
const GRAB_MULTIPLICATOR = 0.7

enum State { IDLE, WALK }

var state = State.IDLE
var lastDirection = Vector2.DOWN
var lastInteractTarget: Node = null

var grabbedBody: StaticBody2D = null
var grabbedObject: Node2D = null
var grabbedComponent: GrabableComponent = null
var grabOffset: Vector2 = Vector2.ZERO
var grabExtraCollision: CollisionShape2D = null
var animationDirection = Vector2.DOWN
var controlsEnabled = true
var hoveredUsable: Usable = null;

@onready var sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var rayCast: RayCast2D = %RayCast

func _init() -> void:
	MainEventBus.send_player_to_marker.connect(teleportToMarker);

func _ready() -> void:
	MainEventBus.image_layer_show_image.connect(func(_image): disableControls())
	MainEventBus.image_layer_hidden.connect(enableControls);
	MainEventBus.level_change.connect(func(_lvl): disableControls());
	MainEventBus.level_changed.connect(enableControls);
	MainEventBus.inventory_opened.connect(disableControls);
	MainEventBus.inventory_closed.connect(enableControls)
	Dialogic.timeline_ended.connect(enableControls);
	Dialogic.timeline_started.connect(disableControls);
	Global.player = self;

func disableControls() -> void:
	controlsEnabled = false
	velocity = Vector2.ZERO
	state = State.IDLE

func enableControls() -> void:
	if(is_inside_tree()):
		await get_tree().process_frame
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
		if grabbedObject:
			velocity = velocity * GRAB_MULTIPLICATOR;
	else:
		state = State.IDLE
		velocity = Vector2.ZERO

	move_and_slide()
	updateGrabbedPosition()
	updateAnimation()
	updateRaycast()
	checkRaycast()

	if Input.is_action_just_pressed("use"):
		if grabbedObject:
			rotateObject()
		elif lastInteractTarget and lastInteractTarget.collision_layer & 4:
			useObject(lastInteractTarget)

	if Input.is_action_just_pressed("grab"):
		if grabbedBody:
			releaseObject()
		elif lastInteractTarget and lastInteractTarget.collision_layer & 8:
			grabObject(lastInteractTarget)

func updateGrabbedPosition() -> void:
	if not grabbedObject:
		return
	grabbedObject.global_position = global_position + grabOffset

func updateAnimation() -> void:
	# if smth is grabbed we don't change animation direction
	if not grabbedObject:
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
	var usable: Usable = collider.get_parent();
	hoveredUsable = usable;
	usable.onHover();

func unhoverUsableObject(collider: Node2D) -> void:
	MainEventBus.usable_object_is_unhovered.emit(collider)
	var usable: Usable = collider.get_parent();
	hoveredUsable = null;
	usable.onUnhover();

func hoverGrabableObject(collider: Node2D) -> void:
	MainEventBus.grabable_object_is_hovered.emit(collider)

func unhoverGrabableObject(collider: Node2D) -> void:
	MainEventBus.grabable_object_is_unhovered.emit(collider)

func grabObject(collider: Node) -> void:
	var parent := collider.get_parent()
	var component := parent.get_node_or_null("GrabableComponent") as GrabableComponent
	if not component:
		push_error("grabObject: parent '%s' has no GrabableComponent child" % parent.name)
		return
	grabbedBody = collider as StaticBody2D
	grabbedObject = parent as Node2D
	grabbedComponent = component
	grabOffset = grabbedObject.global_position - global_position
	add_collision_exception_with(grabbedBody)
	var shapeNode: CollisionShape2D = grabbedBody.get_node("CollisionShape2D")
	grabExtraCollision = CollisionShape2D.new()
	grabExtraCollision.shape = shapeNode.shape
	grabExtraCollision.position = to_local(shapeNode.global_position)
	add_child(grabExtraCollision)
	grabbedComponent.onGrab()
	MainEventBus.grabable_object_grabbed.emit(grabbedObject)

func releaseObject() -> void:
	var releasedObject := grabbedObject
	grabbedComponent.onRelease()
	remove_collision_exception_with(grabbedBody)
	grabExtraCollision.queue_free()
	grabExtraCollision = null
	grabbedBody = null
	grabbedObject = null
	grabbedComponent = null
	MainEventBus.grabable_object_released.emit(releasedObject)

func rotateObject() -> void:
	if not grabbedObject:
		return
	var rotatable = grabbedObject.get_node_or_null("RotatableComponent") as RotatableComponent
	if not rotatable:
		return
	rotatable.rotate()
	var shapeNode: CollisionShape2D = grabbedBody.get_node("CollisionShape2D")
	grabExtraCollision.rotation_degrees = shapeNode.rotation_degrees
	grabExtraCollision.position = to_local(shapeNode.global_position)

func useObject(collider: Node2D) -> void:
	var usableObject: Usable = collider.get_parent()
	usableObject.useObjectWithSignal()
	
func teleportToMarker(marker: Marker2D):
	reparent(marker.get_parent())
	position = marker.position;
	

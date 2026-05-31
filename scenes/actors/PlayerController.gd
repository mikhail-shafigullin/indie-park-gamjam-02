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
@onready var motherSprite: AnimatedSprite2D = %MotherAnimatedSprite2D
@onready var boatSprite: AnimatedSprite2D = %BoatSprite
@onready var rayCast: RayCast2D = %RayCast

var currentSprite;

func _init() -> void:
	MainEventBus.send_player_to_marker.connect(teleportToMarker);

func _ready() -> void:
	MainEventBus.puzzle_layer_show_scene.connect(func(_image): disableControls())
	MainEventBus.puzzle_layer_showed.connect(disableControls);
	MainEventBus.puzzle_layer_hidden.connect(enableControls);
	MainEventBus.level_change.connect(func(_lvl): disableControls());
	MainEventBus.level_changed.connect(enableControls);
	Dialogic.timeline_ended.connect(enableControls);
	Dialogic.timeline_started.connect(disableControls);
	MainEventBus.inventory_opened.connect(disableControls);
	MainEventBus.inventory_closed.connect(enableControls);
	
	currentSprite = sprite;
	boatSprite.frame_changed.connect(_onBoatFrameChanged)

	Global.player = self;

func disableControls() -> void:
	if(is_inside_tree()):
		await get_tree().process_frame
	print("player disabled")
	controlsEnabled = false
	velocity = Vector2.ZERO
	state = State.IDLE

func enableControls() -> void:
	if(is_inside_tree()):
		get_viewport().set_input_as_handled()
	if(Global.currentPuzzle):
		return;
	print("player enabled")
	if(is_inside_tree()):
		await get_tree().process_frame
	controlsEnabled = true
	
func _input(event: InputEvent) -> void:
	if (!Global.currentPuzzle and controlsEnabled 
			and event.is_action_pressed("use") and not event.echo):
		if grabbedObject:
			rotateObject()
		elif lastInteractTarget and lastInteractTarget.collision_layer & 4:
			useObject(lastInteractTarget)
		
	if (!Global.currentPuzzle and controlsEnabled 
			and event.is_action_pressed("grab") and not event.echo):
		if grabbedBody:
			releaseObject()
		elif lastInteractTarget and lastInteractTarget.collision_layer & 8:
			grabObject(lastInteractTarget)

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

func updateGrabbedPosition() -> void:
	if not grabbedObject:
		return
	grabbedObject.global_position = global_position + grabOffset

func updateAnimation() -> void:
	# if smth is grabbed we don't change animation direction
	if not grabbedObject:
		animationDirection = lastDirection;

	var prefix := "walk_" if state == State.WALK else "idle_"
	if(boatSprite.visible):
		currentSprite.play("idle_" + directionName())
	else:
		currentSprite.play(prefix + directionName())
	boatSprite.play(directionName());

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
	grabExtraCollision.disabled = true
	grabExtraCollision.queue_free()
	grabExtraCollision = null
	remove_collision_exception_with(grabbedBody)
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
	MainEventBus.usable_object_used.emit(usableObject);
	
func teleportToMarker(marker: Marker2D):
	reparent(marker.get_parent())
	position = marker.position;
	
func changeCurrentSprite():
	currentSprite.visible = false;
	if(currentSprite == sprite):
		currentSprite = motherSprite;
	else:
		currentSprite = sprite;
	currentSprite.visible = false;

func changeSpriteOnBoatState():
	if(boatSprite.visible):
		changeSpriteOnBoatStateTo(false)
	else:
		changeSpriteOnBoatStateTo(true)

func changeSpriteOnBoatStateTo(isVisible: bool):
	boatSprite.visible = isVisible
	if not isVisible:
		currentSprite.position.y = 16.0

var pixelOffset = 0;

func _onBoatFrameChanged() -> void:
	if boatSprite.visible:
		if(pixelOffset == 0):
			pixelOffset = 1.0;
		else:
			pixelOffset = 0.0;
		currentSprite.position.y = 16.0 + pixelOffset;

func changeSpriteToMom(isMom: bool):
	if(isMom):
		currentSprite = motherSprite;
		motherSprite.visible = true;
		sprite.visible = false;
	else: 
		currentSprite = sprite;
		motherSprite.visible = false;
		sprite.visible = true;
	

func kill() -> void:
	set_process(false)
	controlsEnabled = false
	sprite.play("wakeup", 0)

func wakeup() -> void:
	MainEventBus.request_rpg.emit()
	set_process(false)
	controlsEnabled = false
	sprite.play("wakeup")
	await sprite.animation_finished
	set_process(true)

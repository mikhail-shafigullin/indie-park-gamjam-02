class_name TriggerOnGrabable
extends Area2D

@export var expectedFurniture: Node2D
@export_enum("down", "left", "up", "right") var expectedDirection: int;

var isResolved: bool = false;

func _ready() -> void:
	MainEventBus.grabable_object_released.connect(onGrabableReleased)

func onGrabableReleased(grabableObject: Node2D) -> void:
	if isInsideTrigger(grabableObject):
		if isGrabableObjectCorrect(grabableObject):
			isResolved = true;
			MainEventBus.grabable_object_is_placed_on_trigger.emit(self, grabableObject)

func isGrabableObjectCorrect(grabableObject: Node2D) -> bool:
	if grabableObject.scene_file_path != expectedFurniture.scene_file_path:
		return false
	var rotatableComponent := grabableObject.find_child("RotatableComponent") as RotatableComponent
	if rotatableComponent != null and rotatableComponent.directionIndex != expectedDirection:
		return false
	return true

func isInsideTrigger(grabableObject: Node2D) -> bool:
	var collisionShape := $CollisionShape2D as CollisionShape2D
	if collisionShape == null or collisionShape.shape == null:
		return false

	var query := PhysicsShapeQueryParameters2D.new()
	query.shape = collisionShape.shape
	query.transform = collisionShape.global_transform
	query.collide_with_bodies = true
	query.collide_with_areas = false

	var spaceState := get_world_2d().direct_space_state
	for result in spaceState.intersect_shape(query):
		if result["collider"].get_parent() == grabableObject:
			return true
	return false

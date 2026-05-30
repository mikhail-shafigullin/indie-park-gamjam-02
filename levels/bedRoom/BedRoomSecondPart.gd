extends Level

@onready var bedSprite: AnimatedSprite2D = $BedSprite;
@onready var startMarker: Marker2D = $Start;

var isBoundariesActive = false;
var timer: Timer;

func _ready() -> void:
	bedSprite.play()
	timer = Timer.new();
	timer.wait_time = 1.0;
	timer.one_shot = true
	add_child(timer);
	timer.timeout.connect(func(): isBoundariesActive = true);

func _enter_tree() -> void:
	if MainEventBus.level_changed.is_connected(deactivateBoundaries):
		return
	MainEventBus.level_changed.connect(deactivateBoundaries);

func _exit_tree() -> void:
	MainEventBus.level_changed.disconnect(deactivateBoundaries);

func deactivateBoundaries():
	isBoundariesActive = false;
	timer.start();

func onBoundaryEntered(_body: Node2D) -> void:
	if not _body is PlayerController:
		return
	if not isBoundariesActive:
		return
	LevelContainer.bedroomLevel.sendPlayerToMarker("Start")

func _on_boundary_left_body_entered(body: Node2D) -> void:
	onBoundaryEntered(body);


func _on_boundary_right_body_entered(body: Node2D) -> void:
	onBoundaryEntered(body);


func _on_boundary_up_body_entered(body: Node2D) -> void:
	onBoundaryEntered(body);


func _on_boundary_down_body_entered(body: Node2D) -> void:
	onBoundaryEntered(body);

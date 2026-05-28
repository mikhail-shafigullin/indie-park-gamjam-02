extends Level

@onready var bedSprite: AnimatedSprite2D = $BedSprite;
@onready var startMarker: Marker2D = $Start;
@onready var boundaryLeft: Area2D = $BoundaryLeft;
@onready var boundaryRight: Area2D = $BoundaryRight;
@onready var boundaryUp: Area2D = $BoundaryUp;
@onready var boundaryDown: Area2D = $BoundaryDown;

func _ready() -> void:
	bedSprite.play()
	boundaryLeft.body_entered.connect(onBoundaryEntered)
	boundaryRight.body_entered.connect(onBoundaryEntered)
	boundaryUp.body_entered.connect(onBoundaryEntered)
	boundaryDown.body_entered.connect(onBoundaryEntered)

func onBoundaryEntered(_body: Node2D) -> void:
	LevelContainer.bedroomLevel.sendPlayerToMarker("Start")

extends Level

@onready var starterMarker: Marker2D = %Start;
@onready var puzzle4Button: Usable = %Solve4;
@onready var changeScene: Usable = %ChangeScene;

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animatedSprite2: AnimatedSprite2D = $AnimatedSprite2D2
@onready var animatedSprite3: AnimatedSprite2D = $AnimatedSprite2D3
@onready var animatedSprite4: AnimatedSprite2D = $AnimatedSprite2D4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_enters_room.connect(closeDoorFor4thPuzzle);
	animatedSprite.play()
	animatedSprite2.play()
	animatedSprite3.play()
	animatedSprite4.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func closeDoorFor4thPuzzle():
	if(PuzzleStates.puzzle13Solved == true and 
	PuzzleStates.puzzle4Solved != true):
		changeScene.disable();


func _on_solve_4__object_used() -> void:
	puzzle4Button.disable();
	MainEventBus.puzzle_4_solved.emit();
	changeScene.enable()

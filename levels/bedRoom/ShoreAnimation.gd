extends Node2D

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animatedSprite2: AnimatedSprite2D = $AnimatedSprite2D2
@onready var animatedSprite3: AnimatedSprite2D = $AnimatedSprite2D3
@onready var animatedSprite4: AnimatedSprite2D = $AnimatedSprite2D4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playAnimation();
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func playAnimation():
	animatedSprite.play()
	animatedSprite2.play()
	animatedSprite3.play()
	animatedSprite4.play()

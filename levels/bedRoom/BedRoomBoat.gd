extends Usable

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animatedSprite.play()
	pass # Replace with function body.


func useObject():
	pass

extends Label
@onready var game_manager: Node2D = %GameManager


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_manager:
		text = str(game_manager.stamina)

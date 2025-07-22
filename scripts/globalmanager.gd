extends Node2D

var stamina = 100.0
var bulletheld = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func reset():
	stamina = 100.0
	bulletheld = true

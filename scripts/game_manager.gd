extends Node2D
const PAUSE_MENU = preload("res://scenes/pause_menu.tscn")
const DIALOGUE = preload("res://scenes/dialogue.tscn")
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		var menu = PAUSE_MENU.instantiate()
		get_parent().find_child("CanvasLayer").add_child(menu)
		get_tree().paused = true
	

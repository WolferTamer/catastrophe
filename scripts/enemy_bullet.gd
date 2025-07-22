extends CharacterBody2D

const DEATH_MENU = preload("res://scenes/death_screen.tscn")

func _physics_process(delta: float) -> void:
	move_and_slide()



func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body is CharacterBody2D:
		var character = body as CharacterBody2D
		if character.get_collision_layer_value(2):
			var menu = DEATH_MENU.instantiate()
			get_parent().find_child("CanvasLayer").add_child(menu)
			get_tree().paused = true
	if body is TileMapLayer:
		var layer = body as TileMapLayer
		if layer.tile_set.get_physics_layer_collision_layer(0) == 1:
			queue_free()
	

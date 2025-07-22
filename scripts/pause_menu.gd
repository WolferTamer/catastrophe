extends Control

func _on_resume_pressed() -> void:
	queue_free()
	get_tree().paused = false;


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_edit_pressed() -> void:
	get_tree().quit()

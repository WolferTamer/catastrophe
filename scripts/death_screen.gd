extends Node

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_resume_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	GlobalManager.reset()
	queue_free()

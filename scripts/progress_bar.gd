extends ProgressBar




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value = GlobalManager.stamina
	if value <= 30:
		var style = get_theme_stylebox("Fill")
		if style and style is StyleBoxFlat:
			var sbf = style as StyleBoxFlat
			sbf.bg_color = Color.RED
			add_theme_stylebox_override("Fill", sbf)

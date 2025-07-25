extends Control

@onready var label: Label = $Panel/MarginContainer/Label
@onready var timer: Timer = $LetterDisplayTimer

@export var MAX_WIDTH = 200.0
var text = ""
var letter_index = 0
@export var letter_time = 0.03
@export var space_time = 0.06
@export var punctuation_time = 0.2

signal finished_displaying()

func display_text(text_to_display: String):
	text = text_to_display
	label.text = text_to_display
	
	custom_minimum_size.x = max(size.x,MAX_WIDTH)
	
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		custom_minimum_size.y = size.y
	label.text = ""
	_display_letter()
	
func _display_letter():
	label.text += text[letter_index]
	
	letter_index += 1
	if letter_index >= text.length():
		finished_displaying.emit()
		return
	match text[letter_index]:
		"!",".",",","?":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
		_:
			timer.start(letter_time)


func _on_letter_display_timer_timeout() -> void:
	_display_letter()

extends CharacterBody2D


const SPEED = 80.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var moveright = true
const BULLET = preload("res://scenes/bullet.tscn")

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionx := Input.get_axis("ui_left", "ui_right")
	var directiony := Input.get_axis("ui_up", "ui_down")
	var direction = Vector2(directionx, directiony).normalized() * SPEED
	if directionx :
		velocity.x = direction.x
		if(directionx > 0) :
			moveright = true
		else:
			moveright = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if directiony :
		velocity.y = direction.y
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	if direction.length() > 0:
		if moveright:
			animated_sprite.animation = "walkright"
		else:
			animated_sprite.animation = "walkleft"
	else:
		if moveright:
			animated_sprite.animation = "idleright"
		else:
			animated_sprite.animation = "idleleft"
	
	var clicking := Input.is_action_just_pressed("attack")
	if clicking :
		var bullet = BULLET.instantiate()
		var mousevec = (get_global_mouse_position() - position).normalized()
		bullet.velocity = mousevec * 500.0
		bullet.position = position + mousevec * 10.0
		get_parent().add_child(bullet)

	move_and_slide()
	

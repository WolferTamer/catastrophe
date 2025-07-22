extends CharacterBody2D


const SPEED = 80.0
const DODGESPEED = 100.0

@onready var gun_sprite: AnimatedSprite2D = $GunSprite
@onready var gun_sound: AudioStreamPlayer = $GunSound

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var moveright = true
const BULLET = preload("res://scenes/bullet.tscn")
var dodgeTimer = 0
var dodgeVector : Vector2 = Vector2(0,0)

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_just_pressed("interact"):
		var test: Array[String] = ["wow tihs is some dialogue"]
		DialogueManager.start_dialogue(test)
	var directionx := Input.get_axis("left", "right")
	var directiony := Input.get_axis("up", "down")
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
	
	if dodgeTimer != 0:
		dodgeTimer = max(0,dodgeTimer-delta)
		if dodgeTimer <= .8*.4:
			velocity = dodgeVector * DODGESPEED / 10.0
		else:
			velocity = dodgeVector * DODGESPEED
	elif Input.is_action_just_pressed("dodge") && GlobalManager.stamina > 0:
		if direction.length() == 0:
			direction.x = 1
			if !moveright:
				direction.x *= -1
		dodgeVector = direction.normalized()
		dodgeTimer = .8
		if moveright:
			animated_sprite.play("dodgeright")
		else:
			animated_sprite.play("dodgeleft")
		velocity = dodgeVector * DODGESPEED
		GlobalManager.stamina-=10
	else :
		if direction.length() > 0:
			if moveright:
				animated_sprite.play("walkright")
			else:
				animated_sprite.play("walkleft")
		else:
			if moveright:
				animated_sprite.play("idleright")
			else:
				animated_sprite.play("idleleft")
		
		var clicking := Input.is_action_just_pressed("attack")
		if clicking and GlobalManager.bulletheld:
			GlobalManager.bulletheld = false
			var bullet = BULLET.instantiate()
			var mousevec = (get_global_mouse_position() - position).normalized()
			bullet.velocity = mousevec * 500.0
			bullet.position = position + mousevec * 10.0
			get_parent().add_child(bullet)
			gun_sound.play()
			var camera = find_child("Camera2D")
			if camera:
				camera.apply_shake()
	
	if GlobalManager.bulletheld:
		gun_sprite.visible = true
		var adjustedPos = position + Vector2(0,-8)
		var angle = adjustedPos.angle_to_point(get_global_mouse_position())
		gun_sprite.rotation =  angle
	else:
		gun_sprite.visible = false

	move_and_slide()
	
	#When "dodge" is pressed, set dodgetimer
	#Move at dodgeSpeed in the direction the player was moving
	#After 60% of timer over slow down dodge
	#No extra controls while dodging.
	

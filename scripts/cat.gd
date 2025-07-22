extends CharacterBody2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
var manager: Node2D
@onready var collision_shape_area: CollisionShape2D = $Area2D/CollisionShape2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

@export var SPEED = 20.0
@export var player: Node2D
@export var attackCooldown = 2.0

const BULLET = preload("res://scenes/enemy_bullet.tscn")

var _attackTimer = 0.0
var _attacking = false

func _physics_process(delta: float) -> void:
	if !collision_shape_area.disabled:
		_attackTimer += delta
		
		
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray(PhysicsRayQueryParameters2D.create(global_position, player.global_position + Vector2(0,-4)))

		if (!result.collider or result.collider == player) and not _attacking and _attackTimer >= attackCooldown:
			animated_sprite_2d.animation = "attack"
			_attacking = true
			_attackTimer = 0.0
			
		if _attacking and _attackTimer >= 2.0 :
			var instance = BULLET.instantiate()
			var direction = (player.position - position).normalized() * 150.0
			instance.velocity = direction
			instance.position = global_position
			get_parent().add_child(instance)
			animated_sprite_2d.animation = "idle"
			_attacking = false
			_attackTimer = 0.0
		elif ! _attacking:
			var dir = to_local(navigation_agent.get_next_path_position()).normalized()
			velocity = dir * SPEED
			move_and_slide()
		# Add the gravity.
		#MOVE AND COLLIDE ONLY RETURNS COLLISIONS IF THE PATH IN FRONT OF IT
		#WILL LEAD INTO ONE
		
	if collision_shape_area.disabled and !cpu_particles_2d.emitting:
		queue_free()

func make_path() -> void:
	navigation_agent.target_position = player.global_position

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		var enemy = body as CharacterBody2D
		if enemy.get_collision_layer_value(4):
			audio_stream_player.play()
			collision_shape_area.disabled = true
			animated_sprite_2d.visible = false
			cpu_particles_2d.emitting = true


func _on_timeout() -> void:
	make_path()

extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var cpu_particles: CPUParticles2D = $CPUParticles2D
@onready var collision_shape: CollisionShape2D = $Area2D/CollisionShape2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var hit = false
func _physics_process(delta: float) -> void:
	
	if !cpu_particles.emitting:
		var collision = move_and_collide(velocity * delta)
	if collision_shape.disabled and !cpu_particles.emitting:
		if hit:
			GlobalManager.bulletheld = true
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if !collision_shape.disabled:
		if body is CharacterBody2D:
			var character = body as CharacterBody2D
			if character.get_collision_layer_value(3):
				hit = true
		else:
			collision_shape.disabled = true
			animated_sprite.visible = false
			cpu_particles.emitting = true

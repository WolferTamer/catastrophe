extends CharacterBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	var collide = move_and_collide(velocity * delta)
	if collide:
		collision_shape_2d.disabled = true
		animated_sprite_2d.visible = false
		cpu_particles_2d.emitting = true
	if collision_shape_2d.disabled and !cpu_particles_2d.emitting:
		queue_free()

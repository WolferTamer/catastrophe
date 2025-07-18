extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var cpu_particles: CPUParticles2D = $CPUParticles2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var hit = false
func _physics_process(delta: float) -> void:
	if !hit:
		var collision = move_and_collide(velocity * delta)
		if collision:
			collision_shape.disabled = true
			animated_sprite.visible = false
			cpu_particles.emitting = true
			hit = true
	if hit and !cpu_particles.emitting:
		queue_free()

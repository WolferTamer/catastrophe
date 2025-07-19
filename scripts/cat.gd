extends CharacterBody2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
var manager: Node2D
@onready var collision_shape_area: CollisionShape2D = $Area2D/CollisionShape2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	#MOVE AND COLLIDE ONLY RETURNS COLLISIONS IF THE PATH IN FRONT OF IT
	#WILL LEAD INTO ONE
	move_and_slide()
	if collision_shape_area.disabled and !cpu_particles_2d.emitting:
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		var enemy = body as CharacterBody2D
		if enemy.get_collision_layer_value(4):
			collision_shape_area.disabled = true
			animated_sprite_2d.visible = false
			cpu_particles_2d.emitting = true

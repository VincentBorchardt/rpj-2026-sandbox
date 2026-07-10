extends CharacterBody2D

@export var knockback_speed = 50

var knocked_back = false

func _physics_process(delta):
	if knocked_back:
		move_and_slide()
		var collision = move_and_collide(velocity * delta)
		
		if collision:
			queue_free()


func take_hit(direction):
	velocity = direction * knockback_speed
	knocked_back = true

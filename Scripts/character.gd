extends CharacterBody2D

const MOTION_SPEED = 40 # Pixels/second.

var last_direction = Vector2(1, 0)

func _physics_process(_delta):
	var motion = Vector2()
	motion.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	motion.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	motion.y /= 2
	motion = motion.normalized() * MOTION_SPEED
	#warning-ignore:return_value_discarded
	set_velocity(motion)
	move_and_slide()
	var dir = velocity

	#if dir.length() > 0:
		#last_direction = dir
		#update_animation("walk")
	#else:
		#update_animation("idle")

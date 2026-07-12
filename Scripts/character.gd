extends CharacterBody2D

enum State {
	KNOCKBACK,
	MOVE
}

@onready var hitbox = $Hitbox

const MOTION_SPEED = 40
const KNOCKBACK_SPEED = 100
const KNOCKBACK_TIME = 0.05

var state = State.MOVE
var knockback_timer = 0.0
var knockback_velocity = Vector2.ZERO

var last_direction = Vector2(1, 0)


func _physics_process(delta):
	match state:
		State.MOVE:
			move_state()
			
		State.KNOCKBACK:
			knockback_state(delta)


func move_state():
	var motion = Vector2()
	motion.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	motion.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	motion.y /= 2
	motion = motion.normalized() * MOTION_SPEED
	last_direction = motion.normalized()

	velocity = motion
	move_and_slide()


func knockback_state(delta):
	velocity = knockback_velocity
	move_and_slide()

	knockback_timer -= delta

	if knockback_timer <= 0:
		state = State.MOVE
		velocity = Vector2.ZERO

func take_hit(direction):
	state = State.KNOCKBACK
	knockback_timer = KNOCKBACK_TIME

	knockback_velocity = direction.normalized() * KNOCKBACK_SPEED

	#if dir.length() > 0:
		#last_direction = dir
		#update_animation("walk")
	#else:
		#update_animation("idle")

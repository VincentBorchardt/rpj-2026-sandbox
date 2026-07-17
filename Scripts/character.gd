extends CharacterBody2D

enum State {
	KNOCKBACK,
	ATTACK,
	MOVE
}

@onready var hitbox = $Hitbox/CollisionShape2D
@onready var animations = $Animations

const MOTION_SPEED = 40
const KNOCKBACK_SPEED = 100
const KNOCKBACK_TIME = 0.05

var state = State.MOVE
var knockback_timer = 0.0
var knockback_velocity = Vector2.ZERO
var last_x_direction = 1
var last_y_direction = 1
var last_direction = Vector2(1, 0)

func _ready():
	hitbox.disabled = true

func _physics_process(delta):
	match state:
		State.MOVE:
			move_state()
			
		State.KNOCKBACK:
			knockback_state(delta)
			
		State.ATTACK:
			attack_state()

func move_state():
	var motion = Vector2()
	motion.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	motion.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	motion.y /= 2
	motion = motion.normalized() * MOTION_SPEED
	if motion.x != 0:
		last_x_direction = sign(motion.x)

	if motion.y != 0:
		print(last_y_direction)
		last_y_direction = sign(motion.y)

	if motion != Vector2.ZERO:
		last_direction = motion.normalized()
		
	if Input.is_action_just_pressed("attack"):
		start_attack()
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

func start_attack():
	state = State.ATTACK
	velocity = Vector2.ZERO
	update_hitbox_direction()
	hitbox.disabled = false
	animations.play(get_attack_animation())

func attack_state():
	velocity = Vector2.ZERO
	move_and_slide()

func get_attack_animation() -> String:
	if last_x_direction > 0:
		if last_y_direction < 0:
			return "attack_ne"
		else:
			return "attack_se"

	else:
		if last_y_direction < 0:
			return "attack_nw"
		else:
			return "attack_sw"

func _on_animated_sprite_2d_animation_finished():
	hitbox.disabled = true	
	if state == State.ATTACK:
		state = State.MOVE

func update_hitbox_direction():
	if last_x_direction > 0:
		if last_y_direction < 0:
			#ne
			hitbox.position = Vector2(11, 5)
			hitbox.rotation_degrees = 107.7
		else:
			#se
			hitbox.position = Vector2(8, 14)
			hitbox.rotation_degrees = 107.7

	else:
		#nw
		if last_direction.y < 0:
			hitbox.position = Vector2(-7, 7)
			hitbox.rotation_degrees = 107.7
		else:
		#sw
			hitbox.position = Vector2(-5, 14)
		hitbox.rotation_degrees = 107.7
			

	#if dir.length() > 0:
		#last_direction = dir
		#update_animation("walk")
	#else:
		#update_animation("idle")

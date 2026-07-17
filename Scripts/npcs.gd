extends CharacterBody2D

@export var health = 5


func take_hit():
	print("taking health")
	health -= 1
	if health == 0:
		queue_free()

extends Area2D

var SPEED = 2.0
var Rotation = 0
var direction = 1
var moving = true

func change_direction():
	if direction == 1:
		direction = -1
	elif direction == -1:
		direction = 1

func _physics_process(delta: float) -> void:
	if moving == true:
		if Input.is_action_just_pressed("click"):
			change_direction()
		
		if direction == 1:
			Rotation += 1 * SPEED * delta
		if direction == -1:
			Rotation -= 1 * SPEED * delta
	
		rotation = Rotation

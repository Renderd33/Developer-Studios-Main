extends CharacterBody2D


var speed = 700

func get_input():
	var i_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = i_direction * speed

func _physics_process(delta: float):
	get_input()
	move_and_slide()

extends CharacterBody2D


var speed = 500
var gravity = 30
var jumpForce = 1000

func _physics_process(delta: float):
	velocity.x = 0
	velocity.y += gravity
	
	if Input.is_action_pressed("Left"):
		velocity.x -= speed * delta * 25
	if Input.is_action_pressed("Right"):
		velocity.x += speed * delta * 25
	if (Input.is_action_just_pressed("Up") or Input.is_action_just_pressed("Space")) and is_on_floor():
		velocity.y -= jumpForce
	move_and_slide()
#func get_input(): 
#	var i_direction = Input.get_vector("Left", "Right", "Up", "Down")
#	velocity = i_direction * speed

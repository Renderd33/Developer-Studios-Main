extends CharacterBody2D


var speed = 10000
var gravity = 50

func _physics_process(delta: float):
	velocity.x = 0
	velocity.y += gravity
	
	if Input.is_action_pressed("Left"):
		velocity.x -= speed * delta
	if Input.is_action_pressed("Right"):
		velocity.x += speed * delta
	move_and_slide()
#func get_input(): 
#	var i_direction = Input.get_vector("Left", "Right", "Up", "Down")
#	velocity = i_direction * speed

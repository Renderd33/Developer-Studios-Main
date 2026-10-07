extends CharacterBody2D


const SPEED = 300.0

const JUMP_VELOCITY = -500.0


func ifSlide(slide:float) -> float:
	
	if is_on_floor():
		slide = slide / 1.1
		
	return slide
		

func sprint(run:float) -> float:
	#need to check if direction == true
	if Input.is_action_pressed("Shift") == true and is_on_floor() and run < 1000:
		run += run / 1.1
		
	
	return run
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Space") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, sprint(ifSlide(velocity.x)), SPEED)
	


	move_and_slide()

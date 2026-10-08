extends CharacterBody2D


const SPEED = 300.0

const JUMP_VELOCITY = -500.0

var charMovement = SPEED

func ifSlide(slide:float) -> float:
	
	if is_on_floor():
		slide = slide / 1.1 
		
	return slide

func sprint(movement:float) -> float:
	if Input.is_action_pressed("Shift") and is_on_floor and movement < SPEED * 2 and movement >= SPEED:
		movement += movement / 1.1
	
	return movement
	
	

	



	
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
		
		velocity.x = direction * sprint(charMovement)
		
	else:
		velocity.x = move_toward(velocity.x, ifSlide(velocity.x), charMovement)
	


	move_and_slide()

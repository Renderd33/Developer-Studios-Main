extends CharacterBody2D

const SPEED = 500.0 # this is the speed scaler

const JUMP_VELOCITY = -500.0 # idk what this does

var charMovement = SPEED # this is so the speed will change

func ifSlide(slide:float) -> float: #<---- this will make the object slow down if it is on the floor
	if is_on_floor():
		slide = slide / 1.1 
		
	return slide

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if Input.is_action_just_pressed("LeftClick"):
		var whereMouse = get_local_mouse_position()#<---- this gets the location ofthe mouse compared to the player
		print(whereMouse)
		
		
	if not is_on_floor():
		velocity += get_gravity() * delta
		

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var direction := Input.get_axis("Left", "Right")
	
	if direction:# <------------------------------------- if pressing a left or right botton
		if Input.is_action_pressed("Shift") and is_on_floor() and charMovement < SPEED * 2:
			charMovement = charMovement * 1.03#<------- this is the accelurtion and above is the condition of sprint
		if (not Input.is_action_pressed("Shift")) and is_on_floor():#<----- slows down if still moving
			charMovement = charMovement  * 0.97
		if charMovement <= SPEED: #<---- this makes sure the speed doesn't fall below the min
			charMovement = SPEED
		
		velocity.x = direction * charMovement#<--------- makes the object move
	#                            
	#
	#                            hey, made things to help me read the code so I hope they help you.
	#                            Somethings a little off when you change directions on the floor 
	#                            you just lose all your momentum when you do so idk try to do something
	#                            about that, also make a copy of this code before you mess with it.
	#                            nvm I fix it  think. how do you feel about the movement. 
	#                            (ricardo -- it runs good, might try tweaking some stuff but honestly, it works how its wanted)
	
	else:
		if is_on_floor() and charMovement > SPEED:#<------- this slows the speed down to the min
			charMovement -= charMovement / 1.9
		
		if charMovement <= SPEED: #<---- this makes sure the speed doesn't fall below the min
			charMovement = SPEED
		
		velocity.x = move_toward(velocity.x, ifSlide(velocity.x), charMovement)
		
		

	move_and_slide()

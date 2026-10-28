extends CharacterBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var grapC := $GrappleHookController

const SPEED = 500.0 # this is the speed scaler
const JUMP_VELOCITY = -700.0 # idk what this does
var charMovement = SPEED # this is so the speed will change

#func _ready() -> void:
	#add_to_group("Player")

func respawn():
	self.global_position = Vector2(572,329)

func ifSlide(slide:float) -> float: #<---- this will make the object slow down if it is on the floor
	if is_on_floor():
		slide = slide / 1.1 
		
	return slide

func _physics_process(delta: float) -> void:
	#set_raycast_direction()
	
	# Add the gravity.	
	if Input.is_action_just_pressed("LeftClick"):
		var whereMouse = get_local_mouse_position()#<---- this gets the location ofthe mouse compared to the player
		print(whereMouse)
		#use_le_grapple()
		#return
		
	if not is_on_floor():
		velocity += get_gravity() * delta
		

	# Handle jump.
	if Input.is_action_just_pressed("Space") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var direction := Input.get_axis("Left", "Right")
	
	if direction:# <------------------------------------- if pressing a left or right botton
		if Input.is_action_pressed("Shift") and is_on_floor() and charMovement < SPEED * 1.8:
			charMovement = charMovement * 1.03 + ifSlide(charMovement)#<------- this is the accelurtion and above is the condition of sprint
			if charMovement > SPEED * 1.8:
				charMovement = SPEED * 1.8
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

#func set_active(boi: bool):
	#set_physics_process(boi)
	#collision_shape_2d.disabled = not boi

#func use_le_grapple():
	#if not ray_cast_2d.is_colliding():
	#	return
	
	#set_active(false)
	
	#var startOffset = Vector2(0, -30)
	#global_position += startOffset
	
	#var le_grapple_node = le_grapple.instantiate()
	#get_tree().current_scene.add_child(le_grapple_node)
	#le_grapple_node.start_hook(ray_cast_2d.get_collision_point())

#func set_raycast_direction():
	#var lookDirection = Input.get_vector("Left","Right","Up","Down")
	
	#if lookDirection.y > 0:
	#	return
		
	#ray_cast_2d.look_at(global_position + lookDirection)

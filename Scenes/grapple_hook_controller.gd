extends Node2D

#Hooke's Law variables
@export var rest_length = 20.0
@export var stiffness = 20
@export var damping = 4

@onready var player := get_parent()
@onready var ray := $RayCast2D
@onready var rope := $Line2D


var launched = false
var target: Vector2
 
func _process(delta: float) -> void:
	ray.look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("LeftClick"):
		launch()
	if Input.is_action_just_released("LeftClick"):
		retract()
	
	if launched:
		handle_grapple(delta)

func launch():
	if ray.is_colliding():
		launched = true
		target = ray.get_collision_point()
		rope.show()
		
func retract():
	launched = false
	rope.hide()
	
func handle_grapple(delta):
	var target_dir = player.global_position.direction_to(target)
	var target_dist = player.global_position.distance_to(target)
	
	var displacement = target_dist - rest_length
	
	var force = Vector2.ZERO

#whole bunch of physics shit below	
	if displacement > 0:
		var spring_force_mag = stiffness * displacement
		var spring_force = target_dir * spring_force_mag
		
		var velocity_dot = player.velocity.dot(target_dir)
		var damping = -damping * velocity_dot * target_dir
		
		force = spring_force + damping
	
	player.velocity += force * delta
	update_rope()
	 
func update_rope():
	rope.set_point_position(1, to_local(target))

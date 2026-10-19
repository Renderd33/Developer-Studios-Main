extends Area2D
class_name death



func _on_body_entered(body: Node2D):
	if body.name == "Player":
		body.respawn()

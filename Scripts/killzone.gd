extends Area2D
class_name death



func _on_body_entered(body: Node2D):
	if body.name == "Player":
		
		get_tree().change_scene_to_file("res://GameOver.tscn")
		body.respawn()

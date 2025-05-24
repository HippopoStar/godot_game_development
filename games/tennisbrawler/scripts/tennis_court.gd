extends Node3D

func _on_kill_plane_body_entered(body: Node3D) -> void:
	if body.get_class() == "RigidBody3D":
		body.queue_free()
	if body.get_class() == "CharacterBody3D":
		get_tree().reload_current_scene.call_deferred()

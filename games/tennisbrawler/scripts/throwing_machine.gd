extends Node3D

func throw_ball() -> void:
	const POWER = 15
	const DEGREES = 25
	const TENNIS_BALL: PackedScene = preload("res://scenes/tennis_ball.tscn")

	var tennis_ball: RigidBody3D = TENNIS_BALL.instantiate()
	self.get_parent().add_child(tennis_ball)
	tennis_ball.global_position = self.get_node("Marker3D").global_position
	var direction: Vector3 = (-self.transform.basis.z).rotated(self.transform.basis.x, deg_to_rad(DEGREES))
	tennis_ball.apply_impulse(direction * POWER)

func _on_timer_timeout() -> void:
	self.throw_ball()

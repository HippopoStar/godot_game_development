extends CharacterBody3D

var user_interface: CanvasLayer = null
var camera: Camera3D = null
var angle: float = 0.0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	self.camera = self.get_node("Camera3D")
	self.user_interface = self.get_node("PlayerUI")

func _unhandled_input(event: InputEvent) -> void:
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event.is_action_pressed("ui_cancel"):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		elif event is InputEventMouseMotion:
			self.rotation_degrees.y -= event.relative.x * 0.5
			self.camera.rotation_degrees.x -= event.relative.y * 0.2
			self.camera.rotation_degrees.x = clamp(
				self.camera.rotation_degrees.x, -80.0, 80.0
			)
	elif Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		if event.is_action_pressed("shoot"):
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func deplacement(delta: float) -> void:
	const SPEED: float = 5.5

	var input_direction_2D: Vector2 = Input.get_vector(
		"move_left", "move_right", "move_forward", "move_back"
	)
	var input_direction_3D: Vector3 = Vector3(
		input_direction_2D.x, 0.0, input_direction_2D.y
	)
	var direction: Vector3 = self.transform.basis * input_direction_3D

	self.velocity.x = direction.x * SPEED
	self.velocity.z = direction.z * SPEED

	self.velocity.y -= 20.0 * delta
	if Input.is_action_just_pressed("jump") and self.is_on_floor():
		self.velocity.y = 10.0
	elif Input.is_action_just_released("jump") and self.velocity.y > 0.0:
		self.velocity.y = 0.0

	self.move_and_slide()

func dose_power(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		self.user_interface.get_power_gauge().show()
		self.user_interface.get_power_gauge().set_value_no_signal(0.0)
	elif Input.is_action_just_released("shoot") and self.user_interface.get_power_gauge().is_visible():
		var power: float = self.user_interface.get_power_gauge().get_value()
		self.user_interface.get_power_gauge().hide()
		self.shoot_ball(power)
	elif Input.is_action_pressed("shoot") and self.user_interface.get_power_gauge().is_visible():
		var value: float = self.user_interface.get_power_gauge().get_value() + (50.0 * delta)
		value = clamp(
			value, self.user_interface.get_power_gauge().get_min(), self.user_interface.get_power_gauge().get_max()
		)
		self.user_interface.get_power_gauge().set_value_no_signal(value)

func shoot_ball(power: float) -> void:
	const TENNIS_BALL: PackedScene = preload("res://scenes/tennis_ball.tscn")

	var tennis_ball: RigidBody3D = TENNIS_BALL.instantiate()
	self.get_parent().add_child(tennis_ball)
	tennis_ball.global_position = self.camera.get_node("Marker3D").global_position
	#var one_meter_forward: Vector3 = Vector3.FORWARD.rotated(Vector3.RIGHT, self.get_node("Camera3D").rotation.x).rotated(Vector3.UP, self.rotation.y)
	var one_meter_forward: Vector3 = -self.camera.global_transform.basis.z
	#print("one_meter_forward: " + str(one_meter_forward))
	tennis_ball.apply_central_impulse(one_meter_forward.rotated(Vector3.UP, -self.angle / 100.0 * PI) * power)

func adjust_aim(delta: float) -> void:
	if Input.is_action_just_pressed("stand_still"):
		self.user_interface.get_angle_slider().show()
		self.user_interface.get_angle_slider().set_value_no_signal(self.angle)
	elif Input.is_action_just_released("stand_still"):
		self.angle = 0.0
		self.user_interface.get_angle_slider().hide()
	elif Input.is_action_pressed("stand_still"):
		var input_direction_2D: Vector2 = Input.get_vector(
			"move_left", "move_right", "move_forward", "move_back"
		)
		self.angle += input_direction_2D.x * 100.0 * delta
		self.angle = clamp(
			self.angle, self.user_interface.get_angle_slider().get_min(), self.user_interface.get_angle_slider().get_max()
		)
		self.user_interface.get_angle_slider().set_value_no_signal(self.angle)

func _physics_process(delta: float) -> void:
	if not Input.is_action_pressed("stand_still"): # flat, lift, chop, slice
		self.deplacement(delta)
	self.adjust_aim(delta)
	self.dose_power(delta)

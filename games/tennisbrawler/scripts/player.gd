extends CharacterBody3D

var power_gauge: ProgressBar = null
var camera: Camera3D = null

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	self.camera = self.get_node("Camera3D")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif event is InputEventMouseMotion:
		self.rotation_degrees.y -= event.relative.x * 0.5
		self.camera.rotation_degrees.x -= event.relative.y * 0.2
		self.camera.rotation_degrees.x = clamp(
			self.camera.rotation_degrees.x, -80.0, 80.0
		)

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
	const POWER_GAUGE: PackedScene = preload("res://scenes/power_gauge.tscn")

	if Input.is_action_just_pressed("shoot"):
		self.power_gauge = POWER_GAUGE.instantiate()
		self.add_child(power_gauge)
		self.power_gauge.value = 0
	elif Input.is_action_just_released("shoot"):
		var power: float = self.power_gauge.value
		self.power_gauge.queue_free()
		self.power_gauge = null
		self.shoot_ball(power)
	elif Input.is_action_pressed("shoot"):
		var value: float = self.power_gauge.value + (50.0 * delta)
		self.power_gauge.value = clamp(
			value, 0.0, 100.0
		)

func shoot_ball(power: float) -> void:
	const TENNIS_BALL: PackedScene = preload("res://scenes/tennis_ball.tscn")

	var tennis_ball: RigidBody3D = TENNIS_BALL.instantiate()
	self.get_parent().add_child(tennis_ball)
	tennis_ball.global_position = self.camera.get_node("Marker3D").global_position
	#var one_meter_forward: Vector3 = Vector3.FORWARD.rotated(Vector3.RIGHT, self.get_node("Camera3D").rotation.x).rotated(Vector3.UP, self.rotation.y)
	var one_meter_forward: Vector3 = -self.camera.global_basis.z
	#print("one_meter_forward: " + str(one_meter_forward))
	tennis_ball.apply_central_impulse(one_meter_forward * power)

func _physics_process(delta: float) -> void:
	self.deplacement(delta)
	self.dose_power(delta)

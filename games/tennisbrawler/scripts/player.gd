extends CharacterBody3D

@export var rotate_player: GUIDEAction
@export var rotate_camera: GUIDEAction
@export var move: GUIDEAction
@export var hit_gesture: GUIDEAction
@export var hit_stance: GUIDEAction

var user_interface: CanvasLayer = null
var camera: Camera3D = null

func _ready() -> void:
	self.camera = self.get_node("Camera3D")
	self.user_interface = self.get_node("PlayerUI")

func deplacement(delta: float) -> void:
	const SPEED: float = 5.5

	self.velocity = self.transform.basis * self.move.value_axis_3d * SPEED
	self.rotation_degrees.y += self.rotate_player.value_axis_1d
	self.camera.rotation_degrees.x = clamp(self.camera.rotation_degrees.x + self.rotate_camera.value_axis_1d, -80.0, 80.0)

	if not self.is_on_floor():
		self.velocity.y -= 9.81 * delta

	self.move_and_slide()

func dose_power(delta: float) -> void:
	const LOADING_SPEED: float = 50.0

	if self.hit_gesture.value_bool:
		self.user_interface.get_power_gauge().show()
		self.user_interface.get_power_gauge().set_value_no_signal(
			clamp(
				self.user_interface.get_power_gauge().get_value() + (LOADING_SPEED * delta),
				self.user_interface.get_power_gauge().get_min(),
				self.user_interface.get_power_gauge().get_max()
			)
		)
	elif self.user_interface.get_power_gauge().is_visible():
		self.shoot_ball(
			self.user_interface.get_power_gauge().get_value()
		)
		self.user_interface.get_power_gauge().hide()
		self.user_interface.get_power_gauge().set_value_no_signal(0.0)

func shoot_ball(power: float) -> void:
	const TENNIS_BALL: PackedScene = preload("res://scenes/tennis_ball.tscn")

	var tennis_ball: RigidBody3D = TENNIS_BALL.instantiate()
	self.get_parent().add_child(tennis_ball)
	tennis_ball.global_position = self.camera.get_node("Marker3D").global_position
	#var one_meter_forward: Vector3 = Vector3.FORWARD.rotated(Vector3.RIGHT, self.get_node("Camera3D").rotation.x).rotated(Vector3.UP, self.rotation.y)
	var one_meter_forward: Vector3 = -self.camera.global_transform.basis.z
	#print("one_meter_forward: " + str(one_meter_forward))
	tennis_ball.apply_central_impulse(one_meter_forward.rotated(Vector3.UP, -self.user_interface.get_angle_slider().get_value() / 100.0 * PI) * power)

func adjust_aim(delta: float) -> void:
	const SLIDING_SPEED: float = 100.0

	if self.hit_stance.value_bool:
		self.user_interface.get_angle_slider().show()
		self.user_interface.get_angle_slider().set_value_no_signal(
			clamp(
				self.user_interface.get_angle_slider().get_value() + (self.move.value_axis_3d.x * SLIDING_SPEED * delta),
				self.user_interface.get_angle_slider().get_min(),
				self.user_interface.get_angle_slider().get_max()
			)
		)
	elif self.user_interface.get_angle_slider().is_visible():
		self.user_interface.get_angle_slider().hide()
		self.user_interface.get_angle_slider().set_value_no_signal(0.0)

func _physics_process(delta: float) -> void:
	if not self.hit_stance.value_bool: # flat, lift, chop, slice
		self.deplacement(delta)
	self.adjust_aim(delta)
	self.dose_power(delta)

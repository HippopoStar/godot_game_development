extends Node3D

# https://docs.godotengine.org/en/stable/classes/class_tubetrailmesh.html

var particles_emitter: GPUParticles3D = null
var trail_mesh: CylinderMesh = null
var tennis_ball: RigidBody3D = null
var tennis_ball_previous_global_position: Vector3 = Vector3(0.0, 0.0, 0.0)

func _ready() -> void:
	self.particles_emitter = get_node("GPUParticles3D")
	self.trail_mesh = self.particles_emitter.get_draw_pass_mesh(0)
	self.tennis_ball = self.get_parent()

func init() -> void:
	self.tennis_ball_previous_global_position = self.tennis_ball.global_position

func _physics_process(delta: float) -> void:
	var tennis_ball_global_position: Vector3 = self.tennis_ball.global_position
	var deplacement: Vector3 = tennis_ball_global_position - tennis_ball_previous_global_position
	if deplacement.is_zero_approx():
		self.particles_emitter.set_emitting(false)
	else:
		self.particles_emitter.set_emitting(true)
		self.global_transform.basis = Basis.looking_at(deplacement)
		self.trail_mesh.height = (deplacement.length() / delta) * (self.particles_emitter.lifetime / self.particles_emitter.amount)
		self.particles_emitter.position.z = self.trail_mesh.height / 2.0
	self.tennis_ball_previous_global_position = tennis_ball_global_position

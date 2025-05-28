extends Node3D

# https://docs.godotengine.org/en/stable/classes/class_tubetrailmesh.html

var particles_emitter: GPUParticles3D = null
var cylinder_mesh: CylinderMesh = null
var particule_scale_curve_y: Curve = null
var tennis_ball: RigidBody3D = null
var tennis_ball_previous_global_position: Vector3 = Vector3(0.0, 0.0, 0.0)

func _ready() -> void:
	self.particles_emitter = get_node("GPUParticles3D")
	# GPUParticles3D.get_process_material() -> Material
	# ParticleProcessMaterial.get_param_texture() -> Texture2D
	# CurveXYZTexture.get_curve_y() -> Curve
	self.particule_scale_curve_y = self.particles_emitter.get_process_material().get_param_texture(ParticleProcessMaterial.Parameter.PARAM_SCALE).get_curve_y()
	self.cylinder_mesh = self.particles_emitter.get_draw_pass_mesh(0)
	self.tennis_ball = self.get_parent()

func init() -> void:
	self.tennis_ball_previous_global_position = self.tennis_ball.global_position

# ParticleProcessMaterial, CurveXYZTexture and Curve all have to be "Local to scene"
func scale_cylinder_mesh_height(height: float) -> void:
	var value: float = clamp(height, 0.0, 1.0)
	self.particule_scale_curve_y.set_point_value(0, value)
	self.particule_scale_curve_y.set_point_value(1, value)

# Adjusting either the height or the scale_y of the CylinderMesh emitted by a GPUParticles3D
# affects all the instances currently at display

func _process(delta: float) -> void:
	var tennis_ball_global_position: Vector3 = self.tennis_ball.global_position
	var deplacement: Vector3 = tennis_ball_global_position - tennis_ball_previous_global_position
	if deplacement.is_zero_approx():
		self.particles_emitter.set_emitting(false)
	else:
		var cylinder_mesh_height: float = (deplacement.length() / delta) * (self.particles_emitter.lifetime / self.particles_emitter.amount)
		self.particles_emitter.set_emitting(true)
		self.global_transform.basis = Basis.looking_at(deplacement)
		#self.cylinder_mesh.height = cylinder_mesh_height
		self.scale_cylinder_mesh_height(cylinder_mesh_height)
		self.particles_emitter.position.z = cylinder_mesh_height / 2.0
	self.tennis_ball_previous_global_position = tennis_ball_global_position

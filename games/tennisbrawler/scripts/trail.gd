extends Node3D

# CircularBuffer
# https://docs.godotengine.org/en/stable/classes/class_array.html
var segments_array: Array = Array()
var index: int = 0

var previous_global_position: Vector3 = Vector3(0.0, 0.0, 0.0)

# ProjectSettings.get_setting("physics/common/physics_ticks_per_second") -> int
# Engine.get_physics_ticks_per_second() -> int
# ProjectSettings.get_setting("application/run/max_fps") -> int
# Engine.get_max_fps() -> int
# Engine.get_frames_per_second() -> float

# Trail duration = GRANULARITY / FPS
const GRANULARITY: int = 60
var color: Color = Color(1.0, 1.0, 1.0, 1.0)
var alpha_step: float = 0.0

func update_alpha() -> void:
	for segment in self.segments_array:
		var segment_color = segment.get_node("MeshInstance3D").get_mesh().get_material().get_albedo()
		segment.get_node("MeshInstance3D").get_mesh().get_material().set_albedo(segment_color - Color(0, 0, 0, self.alpha_step))

func update_segment(delta: float, segment: Node3D) -> void:
	var deplacement: Vector3 = self.global_position - self.previous_global_position
	if deplacement.is_zero_approx():
		segment.set_visible(false)
	else:
		segment.set_visible(true)
		#var cylinder_mesh_height: float = (self.get_parent().get_linear_velocity() * delta).length()
		var cylinder_mesh_height: float = deplacement.length()
		# MeshInstance3D.get_mesh() -> Mesh
		# CylinderMesh.set_height(value: float) -> void
		segment.get_node("MeshInstance3D").get_mesh().set_height(cylinder_mesh_height)
		segment.get_node("MeshInstance3D").transform.origin.z = cylinder_mesh_height / 2.0
		segment.global_transform.basis = Basis.looking_at(deplacement) # Might cause unintended rotations (see Quaternion)
		segment.global_transform.origin = self.global_position
	segment.get_node("MeshInstance3D").get_mesh().get_material().set_albedo(self.color)
	self.previous_global_position = self.global_position

func _process(delta: float) -> void:
	const TRAIL_SEGMENT: PackedScene = preload("res://scenes/trail_segment.tscn")

	var segment: Node3D = null
	if self.segments_array.size() < self.GRANULARITY:
		self.segments_array.append(TRAIL_SEGMENT.instantiate())
		segment = self.segments_array.back()
		segment.set_as_top_level(true)
		self.add_child(segment)
		if self.segments_array.size() == 1:
			# Node.get_node(path: NodePath) -> Node
			# MeshInstance3D.get_mesh() -> Mesh
			# PrimitiveMesh.get_material() -> Material
			# BaseMaterial3D.get_albedo() -> Color
			self.color = segment.get_node("MeshInstance3D").get_mesh().get_material().get_albedo()
			self.alpha_step = self.color.a / self.GRANULARITY
			# Workaround to skip first cylinder visual artifact
			self.previous_global_position = self.global_position
	else:
		segment = self.segments_array.get(self.index)
		self.index = (self.index + 1) % self.GRANULARITY
	self.update_alpha()
	self.update_segment(delta, segment)

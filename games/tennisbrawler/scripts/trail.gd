extends Node3D

# https://docs.godotengine.org/en/stable/classes/class_array.html

var previous_global_position: Vector3 = Vector3(0.0, 0.0, 0.0)
var segments_array: Array = Array()
var index: int = 0

# ProjectSettings.get_setting("physics/common/physics_ticks_per_second") -> int
# Engine.get_physics_ticks_per_second() -> int
# ProjectSettings.get_setting("application/run/max_fps") -> int
# Engine.get_max_fps() -> int
# Engine.get_frames_per_second() -> float

# Trail duration = FPS / GRANULARITY
const GRANULARITY: int = 30

func update_segment(delta: float, segment: Node3D) -> void:
	var deplacement: Vector3 = self.global_position - self.previous_global_position
	if deplacement.is_zero_approx():
		segment.set_visible(false)
	else:
		segment.set_visible(true)
		var cylinder_mesh_height: float = (deplacement.length() / delta) / self.GRANULARITY
		# MeshInstance3D.get_mesh() -> Mesh
		# CylinderMesh.set_height(value: float) -> void
		segment.get_node("MeshInstance3D").get_mesh().set_height(cylinder_mesh_height)
		segment.get_node("MeshInstance3D").transform.origin.z = cylinder_mesh_height / 2.0
		segment.global_transform.basis = Basis.looking_at(deplacement)
		segment.global_transform.origin = self.global_position
	self.previous_global_position = self.global_position

func _process(delta: float) -> void:
	const TRAIL_SEGMENT = preload("res://scenes/trail_segment.tscn")

	var segment: Node3D = null
	if self.segments_array.size() < self.GRANULARITY:
		self.segments_array.append(TRAIL_SEGMENT.instantiate())
		segment = self.segments_array.back()
		segment.set_as_top_level(true)
		self.add_child(segment)
		if self.segments_array.size() == 1:
			# Workaround to skip first cylinder visual artifact
			self.previous_global_position = self.global_position
	else:
		segment = self.segments_array.get(self.index)
		self.index = (self.index + 1) % self.GRANULARITY
	update_segment(delta, segment)

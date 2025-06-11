extends Node3D

@export var switch_to_serve_mode: GUIDEAction
@export var switch_to_rally_mode: GUIDEAction
@export var toggle_settings_dialog: GUIDEAction

func _ready() -> void:
	switch_to_serve_mode.triggered.connect(self._switch_to_serve_mode)
	switch_to_rally_mode.triggered.connect(self._switch_to_rally_mode)
	toggle_settings_dialog.triggered.connect(self._toggle_settings_dialog)
	self._switch_to_serve_mode()

func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_cancel"):
		#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass

func _switch_to_serve_mode() -> void:
	pass

func _switch_to_rally_mode() -> void:
	pass

func _toggle_settings_dialog() -> void:
	# Node.get_tree() -> SceneTree
	# SceneTree.is_paused() -> bool
	self.get_tree().set_pause(not self.get_tree().is_paused())

func _on_kill_plane_body_entered(body: Node3D) -> void:
	if body.get_class() == "RigidBody3D":
		body.queue_free()
	if body.get_class() == "CharacterBody3D":
		get_tree().reload_current_scene.call_deferred()

extends PanelContainer

@export var global_kbm: GUIDEMappingContext
@export var global_controller: GUIDEMappingContext
@export var serve_kbm: GUIDEMappingContext
@export var serve_controller: GUIDEMappingContext
@export var rally_kbm: GUIDEMappingContext
@export var rally_controller: GUIDEMappingContext

@export var toggle_settings_dialog: GUIDEAction

var _tab_container: TabContainer = null
var _keyboard_and_mouse_container: Container = null
var _controller_container: Container = null
var _input_prompt: Container = null
var _input_detector: GUIDEInputDetector = null

var _remapper: GUIDERemapper = null
var _guide_input_formatter: GUIDEInputFormatter = null

func _ready() -> void:
	self._remapper = GUIDERemapper.new()
	self._guide_input_formatter = GUIDEInputFormatter.new(48)
	self._tab_container = self.get_node("VBoxContainer/TabContainer")
	self._tab_container.set_tab_title(0, "Keyboard & Mouse")
	self._keyboard_and_mouse_container = self._tab_container.get_node("KBM")
	self._controller_container = self._tab_container.get_node("Controller")
	self._input_prompt = self.get_node("CenterContainer")
	self._input_detector = self.get_node("GUIDEInputDetector")
	toggle_settings_dialog.triggered.connect(self._toggle_visibility)

func _toggle_visibility() -> void:
	self.set_visible(not self.is_visible())

	if not self.is_visible():
		var new_config: GUIDERemappingConfig = self._remapper.get_mapping_config()
		GUIDE.set_remapping_config(new_config)
	else:
		if GUIDE.is_mapping_context_enabled(global_kbm):
			self._tab_container.current_tab = 0
		else:
			self._tab_container.current_tab = 1
		self._tab_container.get_tab_bar().grab_focus()

		var remapping_config: GUIDERemappingConfig = self._remapper.get_mapping_config()
		# https://github.com/godotneers/G.U.I.D.E/blob/main/addons/guide/remapping/guide_remapper.gd
		self._remapper.initialize(
			[
				global_kbm,
				global_controller,
				serve_kbm,
				serve_controller,
				rally_kbm,
				rally_controller
			],
			remapping_config
		)

		self._clear(self._keyboard_and_mouse_container)
		self._clear(self._controller_container)

		self._build_section(self._keyboard_and_mouse_container, "Serve", serve_kbm)
		self._build_section(self._keyboard_and_mouse_container, "Rally", rally_kbm)
		self._build_section(self._controller_container, "Serve", serve_controller)
		self._build_section(self._controller_container, "Rally", rally_controller)

func _clear(container: Container) -> void:
	for child in container.get_children():
		container.remove_child(child)
		child.queue_free()

func _build_section(container: Container, title: String, mapping_context: GUIDEMappingContext) -> void:
	const INPUT_SECTION: PackedScene = preload("res://resources/G.U.I.D.E/ui/input_section.tscn")
	const INPUT_BINDING: PackedScene = preload("res://resources/G.U.I.D.E/ui/input_binding.tscn")

	var input_section: InputSection = INPUT_SECTION.instantiate()
	container.add_child(input_section)
	input_section.title = title
	var items: Array[GUIDERemapper.ConfigItem] = self._remapper.get_remappable_items(mapping_context)
	for item: GUIDERemapper.ConfigItem in items:
		var input_binding = INPUT_BINDING.instantiate()
		container.add_child(input_binding)
		input_binding.title = item.display_name
		var input: GUIDEInput = self._remapper.get_bound_input_or_null(item)
		self._update_bound_input(input, input_binding)
		item.changed.connect(self._update_bound_input.bind(input_binding))
		input_binding.binding_change_requested.connect(self._on_binding_change_requested.bind(item))

func _update_bound_input(input: GUIDEInput, input_binding: InputBinding) -> void:
	input_binding.bound_input = await self._guide_input_formatter.input_as_richtext_async(input)

func _on_binding_change_requested(item: GUIDERemapper.ConfigItem) -> void:
	self._input_prompt.show()

	var devices: Array[GUIDEInputDetector.DeviceType] = []
	if item.context == serve_kbm or item.context == rally_kbm:
		devices = [GUIDEInputDetector.DeviceType.KEYBOARD, GUIDEInputDetector.DeviceType.MOUSE]
	else:
		devices = [GUIDEInputDetector.DeviceType.JOY]

	self._input_detector.detect(item.value_type, devices)
	var detected_input: GUIDEInput = await self._input_detector.input_detected
	self._input_prompt.hide()

	if not detected_input == null:
		var collisions: Array[GUIDERemapper.ConfigItem] = self._remapper.get_input_collisions(item, detected_input)
		if not collisions.any(
			func (collision: GUIDERemapper.ConfigItem) -> bool:
				if collision.context == global_kbm or collision.context == global_controller:
					return true
				elif item.context == collision.context:
					if not collision.is_remappable:
						return true
					self._remapper.set_bound_input(collision, null)
				return false
		):
			self._remapper.set_bound_input(item, detected_input)

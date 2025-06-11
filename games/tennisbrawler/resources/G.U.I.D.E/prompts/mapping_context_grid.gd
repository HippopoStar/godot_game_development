extends GridContainer

var _show_in_contexts: Array[GUIDEMappingContext] = []

func _ready() -> void:
	GUIDE.input_mappings_changed.connect(self._update_grid)

func initialize(show_in_contexts: Array[GUIDEMappingContext]) -> void:
	self._show_in_contexts = show_in_contexts
	# https://github.com/godotneers/G.U.I.D.E/blob/main/addons/guide/guide_mapping_context.gd
	# https://github.com/godotneers/G.U.I.D.E/blob/main/addons/guide/guide_action_mapping.gd
	# https://github.com/godotneers/G.U.I.D.E/blob/main/addons/guide/guide_action.gd
	var actions: Array[GUIDEAction] = []
	for mapping_context: GUIDEMappingContext in self._show_in_contexts:
		for action_mapping: GUIDEActionMapping in mapping_context.mappings:
			if not actions.has(action_mapping.action):
				actions.append(action_mapping.action)
	for action: GUIDEAction in actions:
		self._build_action_prompt(action)
	self._update_grid()

func _build_action_prompt(action: GUIDEAction):
	const ACTION_ICON: PackedScene = preload("res://resources/G.U.I.D.E/prompts/action_icon.tscn")
	const ACTION_LABEL: PackedScene = preload("res://resources/G.U.I.D.E/prompts/action_label.tscn")

	var action_icon: RichTextLabel = ACTION_ICON.instantiate()
	self.add_child(action_icon)
	var action_label: Label = ACTION_LABEL.instantiate()
	self.add_child(action_label)

	action_icon.initialize(action)
	action_label.set_text(action._editor_name())

func _update_grid() -> void:
	if not self._show_in_contexts.is_empty():
		if not self._show_in_contexts.any(func (context) -> bool: return GUIDE.is_mapping_context_enabled(context)):
			self.hide()
		else:
			self.show()

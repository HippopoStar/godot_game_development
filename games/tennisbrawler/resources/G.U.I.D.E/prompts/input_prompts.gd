extends VBoxContainer

@export var global_kbm: GUIDEMappingContext
@export var global_controller: GUIDEMappingContext
@export var serve_kbm: GUIDEMappingContext
@export var serve_controller: GUIDEMappingContext
@export var rally_kbm: GUIDEMappingContext
@export var rally_controller: GUIDEMappingContext

# https://docs.godotengine.org/en/stable/classes/class_@gdscript.html#class-gdscript-annotation-onready
# Dictionary(base: Dictionary, key_type: int, key_class_name: StringName, key_script: Variant, value_type: int, value_class_name: StringName, value_script: Variant)
# Array(base: Array, type: int, class_name: StringName, script: Variant)
@onready var _mapping_contexts: Dictionary = Dictionary(
	{
		"serve": Array(
			[
				serve_kbm,
				serve_controller
			],
			TYPE_OBJECT, "Resource", GUIDEMappingContext
		),
		"rally": Array(
			[
				rally_kbm,
				rally_controller
			],
			TYPE_OBJECT, "Resource", GUIDEMappingContext
		)
	},
	TYPE_STRING, "", null,
	TYPE_ARRAY, "", null
)

func _ready() -> void:
	print(self._mapping_contexts)
	for game_mode: String in self._mapping_contexts.keys():
		self._build_context_prompt(game_mode)

func _build_context_prompt(game_mode: String) -> void:
	const MAPPING_CONTEXT_GRID: PackedScene = preload("res://resources/G.U.I.D.E/prompts/mapping_context_grid.tscn")

	if self._mapping_contexts.has(game_mode):
		var mapping_context_grid: GridContainer = MAPPING_CONTEXT_GRID.instantiate()
		self.add_child(mapping_context_grid)
		mapping_context_grid.initialize(self._mapping_contexts.get(game_mode))

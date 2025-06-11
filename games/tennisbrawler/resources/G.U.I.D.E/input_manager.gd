extends Node

@export var global_kbm: GUIDEMappingContext
@export var serve_mode_kbm: GUIDEMappingContext
@export var rally_mode_kbm: GUIDEMappingContext

@export var global_controller: GUIDEMappingContext
@export var serve_mode_controller: GUIDEMappingContext
@export var rally_mode_controller: GUIDEMappingContext

@export var switch_to_controller: GUIDEAction
@export var switch_to_kbm: GUIDEAction

@export var switch_to_serve_mode: GUIDEAction
@export var switch_to_rally_mode: GUIDEAction

@export var toggle_settings_dialog: GUIDEAction

var _in_settings: bool = false

enum InputMode {
	KEYBOARD_AND_MOUSE,
	CONTROLLER
}
var _input_mode: InputMode = InputMode.KEYBOARD_AND_MOUSE

enum GameMode {
	SERVE_MODE,
	RALLY_MODE
}
var _game_mode: GameMode = GameMode.SERVE_MODE

func _ready() -> void:
	switch_to_controller.triggered.connect(self._set_input_mode.bind(InputMode.CONTROLLER))
	switch_to_kbm.triggered.connect(self._set_input_mode.bind(InputMode.KEYBOARD_AND_MOUSE))

	switch_to_serve_mode.triggered.connect(self._set_game_mode.bind(GameMode.SERVE_MODE))
	switch_to_rally_mode.triggered.connect(self._set_game_mode.bind(GameMode.RALLY_MODE))

	toggle_settings_dialog.triggered.connect(self._toggle_settings)

	self._update_input()

func _toggle_settings() -> void:
	self._in_settings = not self._in_settings
	self._update_input()

func _set_game_mode(game_mode: GameMode) -> void:
	self._game_mode = game_mode
	self._update_input()

func _set_input_mode(input_mode: InputMode) -> void:
	self._input_mode = input_mode
	self._update_input()

func _update_input() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	match self._input_mode:
		InputMode.KEYBOARD_AND_MOUSE:
			GUIDE.enable_mapping_context(global_kbm, true)
			if self._in_settings:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			else:
				match self._game_mode:
					GameMode.SERVE_MODE:
						GUIDE.enable_mapping_context(serve_mode_kbm)
					GameMode.RALLY_MODE:
						GUIDE.enable_mapping_context(rally_mode_kbm)
		InputMode.CONTROLLER:
			GUIDE.enable_mapping_context(global_controller, true)
			if self._in_settings:
				pass
			else:
				match self._game_mode:
					GameMode.SERVE_MODE:
						GUIDE.enable_mapping_context(serve_mode_controller)
					GameMode.RALLY_MODE:
						GUIDE.enable_mapping_context(rally_mode_controller)

class_name InputBinding
extends HBoxContainer

signal binding_change_requested()

@export var title: String:
	set(value):
		title = value
		self._refresh()

@export var bound_input: String:
	set(value):
		bound_input = value
		self._refresh()

var _title: Button = null
var _bound_input: RichTextLabel = null

func _ready() -> void:
	self._bound_input = self.get_node("RichTextLabel")
	self._title = self.get_node("Button")
	self._title.pressed.connect(func () -> void: binding_change_requested.emit())
	self._refresh()

func _refresh() -> void:
	if self.is_node_ready():
		self._title.set_text(title)
		self._bound_input.set_text(bound_input)

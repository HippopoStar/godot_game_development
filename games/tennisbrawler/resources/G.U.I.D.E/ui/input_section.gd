class_name InputSection
extends PanelContainer

@export var title:String:
	set(value):
		title = value
		self._refresh()

var _title: Label = null

func _ready() -> void:
	self._title = self.get_node("Label")
	self._refresh()

func _refresh() -> void:
	if self.is_node_ready():
		self._title.text = title

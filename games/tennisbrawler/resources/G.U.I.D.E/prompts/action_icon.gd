extends RichTextLabel

var _action: GUIDEAction = null
var _formatter: GUIDEInputFormatter = null

func _ready() -> void:
	self._formatter = GUIDEInputFormatter.for_active_contexts(16)
	GUIDE.input_mappings_changed.connect(self._update_icon)

func initialize(action) -> void:
	self._action = action
	self._update_icon()

func _update_icon() -> void:
	if not self._action == null:
		# https://github.com/godotneers/G.U.I.D.E/blob/main/addons/guide/ui/guide_input_formatter.gd
		self.set_text(await self._formatter.action_as_richtext_async(self._action))

extends CanvasLayer

var power_gauge: ProgressBar = null
var angle_slider: HScrollBar = null

func _ready() -> void:
	self.power_gauge = self.get_node("PowerGaugeContainer/HBoxContainer/PanelContainer/ProgressBar")
	self.power_gauge.hide()
	self.angle_slider = self.get_node("AngleSliderContainer/VBoxContainer/PanelContainer/HScrollBar")
	self.angle_slider.hide()

func get_power_gauge() -> ProgressBar:
	return self.power_gauge

func get_angle_slider() -> HScrollBar:
	return self.angle_slider

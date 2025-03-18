extends Node2D

func _ready():
	update_size()  # Ensure the ColorRect resizes at startup
	get_viewport().connect("size_changed", Callable(self, "update_size"))  # Update on resize

func update_size():
	var color_rect = $ColorRect
	color_rect.size = get_viewport_rect().size  # Resize to match viewport

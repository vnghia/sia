extends Sprite

const LIST_SUPPORTED_UI = {
	"question": Rect2(384, 0, 48, 96),
	"love": Rect2(288, 0, 48, 96)
}

func _ready():
	pass

func switch(ui: String):
	var rect = LIST_SUPPORTED_UI.get(ui)
	if rect != null:
		self.region_rect = rect

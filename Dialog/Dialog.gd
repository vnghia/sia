extends CanvasLayer

const SCROLL_SPEED = 150

var previous_listener = null
var v_scroll = $Box/Content.get_v_scroll()
var should_close = false


func _ready():
	var _err = World_Globals.connect("change_listener", self, "_on_change_listener")


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		if v_scroll.value + v_scroll.page >= v_scroll.max_value:
			World_Globals.emit_signal(
				"change_listener", self, previous_listener
			)
			previous_listener = null


func _process(delta):
	if Input.is_action_pressed("ui_down"):
		v_scroll.value += delta * SCROLL_SPEED
	elif Input.is_action_pressed("ui_up"):
		v_scroll.value -= delta * SCROLL_SPEED


func print_dialog(username: String, speech: String, call: Node):
	print_stack()
	$Box/Name.clear()
	$Box/Name.push_color(Color("#4d4d4d"))
	$Box/Name.push_bold()
	$Box/Name.push_underline()
	$Box/Name.append_bbcode(username)
	$Box/Name.pop()

	$Box/Content.clear()
	$Box/Content.push_color(Color("#4d4d4d"))
	$Box/Content.append_bbcode(speech)
	$Box/Name.pop()

	World_Globals.emit_signal("change_listener", call, self)


func _on_change_listener(old: Node, new: Node):
	if new != self:
		self.get_node("Box").visible = false
		self.set_process(false)
		self.set_process_unhandled_input(false)
	else:
		self.get_node("Box").visible = true
		self.set_process(true)
		self.set_process_unhandled_input(true)
		previous_listener = old

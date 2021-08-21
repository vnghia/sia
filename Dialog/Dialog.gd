extends Node2D

const SCROLL_SPEED = 150

var previous_input_node = null
var v_scroll = $Box/Content.get_v_scroll()
var should_close = false


func _ready():
	self.visible = false
	World_Globals.connect("change_listener", self, "_on_change_listener")


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		if v_scroll.value + v_scroll.page >= v_scroll.max_value:
			World_Globals.emit_signal("change_listener", Player_Globals.player_node)


func _process(delta):
	if Input.is_action_pressed("ui_down"):
		v_scroll.value += delta * SCROLL_SPEED
	elif Input.is_action_pressed("ui_up"):
		v_scroll.value -= delta * SCROLL_SPEED


func print_dialog(username: String, speech: String):
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

	World_Globals.emit_signal("change_listener", self)


func _on_change_listener(node: Node):
	if node != self:
		self.visible = false
		self.set_process(false)
		self.set_process_unhandled_input(false)
	else:
		self.visible = true
		self.set_process(true)
		self.set_process_unhandled_input(true)

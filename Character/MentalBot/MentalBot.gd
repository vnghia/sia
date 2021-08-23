extends KinematicBody2D

var current_state = "begin"
var reminded = false
onready var promo = get_node("/root/Root/Promo")


func _init():
	self.set_meta("name", "MentalBot")


func _ready():
	$Idle.texture = load("res://Character/MentalBot/idle.png")
	$Run.texture = load("res://Character/MentalBot/run.png")
	$UI.switch("question")
	MentalBot_Globals.mentalbot_node = self
	var _err = promo.connect("timeout", self, "_on_promo_timeout")
	_err = World_Globals.connect("change_listener", self, "_on_change_listener")


func interact():
	if current_state == "begin":
		World_Globals.dialog_system.print_dialog(
			self.get_meta("name"),
			"Hello {0} ! How are you feeling today ?".format(
				[Player_Globals.player_node.get_meta("name")]
			),
			Player_Globals.player_node
		)
		$UI.switch("love")
		current_state = "end"
		promo.start()


func _on_promo_timeout():
	if reminded:
		return
	promo.stop()
	$UI.switch("clock")
	World_Globals.world_node.add_child(self)
	self.position = (
		Player_Globals.player_node.position
		- Vector2(0, Player_Globals.player_node.get_node("Interaction").position.y / 1.5)
	)
	World_Globals.dialog_system.print_dialog(
		self.get_meta("name"), "Time for a short break !", Player_Globals.player_node
	)
	reminded = true


func _on_change_listener(_old: Node, new: Node):
	if new != self:
		self.set_process(false)
		self.set_physics_process(false)
		self.set_process_unhandled_input(false)
		if new == Player_Globals.player_node:
			promo.start()
			World_Globals.world_node.remove_child(self)
	else:
		self.set_process(true)
		self.set_physics_process(true)
		self.set_process_unhandled_input(true)

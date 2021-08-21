extends KinematicBody2D


func _init():
	self.set_meta("name", "MentalBot")


func _ready():
	$Idle.texture = load("res://Character/MentalBot/idle.png")
	$Run.texture = load("res://Character/MentalBot/run.png")
	var scenes = World_Globals.list_scenes
	var tile_map = scenes["Welcome"]["instance"].get_node("WallFloor")
	var used_rect = tile_map.get_used_rect()
	var pos = tile_map.map_to_world(used_rect.position)
	var end = tile_map.map_to_world(used_rect.end)
	self.position = (pos + end) / 2


func interact():
	World_Globals.dialog_system.print_dialog(
		self.get_meta("name"),
		"Hello {0} ! Welcome Aboard ! I'm MentalBot.".format(
			[Player_Globals.player_node.get_meta("name")]
		)
	)

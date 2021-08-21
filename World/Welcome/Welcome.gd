extends Node2D

var npc_list = []


func _ready():
	var used_rect = $WallFloor.get_used_rect()
	var pos = $WallFloor.map_to_world(Vector2(used_rect.end.x, used_rect.end.y - 2))
	var offset = $WallFloor.map_to_world(Vector2(used_rect.position.x, used_rect.position.y))
	Player_Globals.player_node.position = Vector2((pos.x + offset.x) / 2, pos.y + offset.y)
	if ! npc_list.size():
		var mental_bot = preload("res://Character/MentalBot/MentalBot.tscn").instance()
		self.add_child(mental_bot)
		npc_list.append(mental_bot)
		for _i in range(2):
			var npc = Character_Globals.new_npc(
				preload("res://Character/Player/idle.png"),
				preload("res://Character/Player/run.png"),
				World_Globals.get_random_world_position_on_tilemap($WallFloor, 1, true, true)
			)
			self.add_child(npc)
			npc_list.append(npc)

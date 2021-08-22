extends Node2D

var npcs = []


func _ready():
	var used_rect = $WallFloor.get_used_rect()
	var pos = $WallFloor.map_to_world(Vector2(used_rect.end.x, used_rect.end.y - 2))
	var offset = $WallFloor.map_to_world(Vector2(used_rect.position.x, used_rect.position.y))
	Player_Globals.player_node.position = Vector2((pos.x + offset.x) / 2, pos.y + offset.y)
	self.get_parent().get_node("MentalBot").position = (pos + offset) / 2
	if ! npcs.size():
		npcs.append_array(Character_Globals.gen_random_npcs(5, $WallFloor, 1))
		for npc in npcs:
			self.add_child(npc)

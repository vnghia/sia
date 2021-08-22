extends Node2D

var npcs = []


func _ready():
	if ! npcs.size():
		npcs.append_array(Character_Globals.gen_random_npcs(30, $WallFloor, 1))
		for npc in npcs:
			self.add_child(npc)

extends Node2D

var NPC = null


func _ready():
	var used_rect = $WallFloor.get_used_rect()
	var pos = $WallFloor.map_to_world(Vector2(used_rect.end.x, used_rect.end.y - 2))
	var offset = $WallFloor.map_to_world(Vector2(used_rect.position.x, used_rect.position.y))
	Player_Globals.player_node.position = Vector2((pos.x + offset.x) / 2, pos.y + offset.y)
	if ! NPC:
		NPC = preload("res://Character/MentalBot/MentalBot.tscn").instance()
		self.add_child(NPC)

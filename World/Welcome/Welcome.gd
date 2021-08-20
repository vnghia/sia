extends Node2D


func _enter_tree():
	var used_rect = $WallFloor.get_used_rect()
	var pos = $WallFloor.map_to_world(Vector2(used_rect.end.x, used_rect.end.y - 2))
	var offset = $WallFloor.map_to_world(Vector2(used_rect.position.x, used_rect.position.y))
	Character_Globals.CharacterNode.position = Vector2((pos.x + offset.x) / 2, pos.y + offset.y)

extends Node2D

func _enter_tree():
	var end = $WallFloor.get_used_rect().end
	var real_pos = $WallFloor.map_to_world(Vector2(end.x, end.y - 2))
	Character_Globals.CharacterNode.position = Vector2(real_pos.x / 2, real_pos.y)

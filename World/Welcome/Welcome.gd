extends Node2D

func _enter_tree():
	var size = $WallFloor.get_used_rect().size
	var real_pos = $WallFloor.map_to_world(Vector2(size.x, size.y - 1))
	Character_Globals.CharacterNode.position = Vector2(real_pos.x / 2, real_pos.y)

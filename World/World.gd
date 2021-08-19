extends Node2D


func _ready():
	var _err = Character_Globals.CharacterNode.connect("collided", self, "_on_Character_collided")
	var scenes = World_Globals.list_scenes
	scenes["Welcome"]["instance"] = load(scenes["Welcome"]["res"]).instance()
	self.add_child(scenes["Welcome"]["instance"], true)
	World_Globals.current_scene = "Welcome"

func _on_collided_change_scene(collision: KinematicCollision2D):
	var scenes = World_Globals.list_scenes
	var current_scene = scenes[World_Globals.current_scene]
	var current_collider = null
	for collider in current_scene["door"].keys():
		if collision.collider == get_node_or_null(collider):
			current_collider = current_scene["door"][collider]
	if ! current_collider:
		return false

	var tile_pos = collision.collider.world_to_map(collision.position)
	var to_scene_name = null
	for door in current_collider.keys():
		var door_data = current_collider[door]
		if door_data["normal"]:
			tile_pos -= collision.normal
		var tile_id = collision.collider.get_cellv(tile_pos)
		var tile_name = collision.collider.tile_set.tile_get_name(tile_id)
		if tile_name == door:
			to_scene_name = door_data["to"]
			break
	if ! to_scene_name:
		return false
	
	self.remove_child(current_scene["instance"])
	var to_scene = scenes[to_scene_name]
	if to_scene["instance"] == null:
		to_scene["instance"] = load(to_scene["res"]).instance()
	self.add_child(to_scene["instance"])
	World_Globals.current_scene = to_scene_name
	return true


func _on_Character_collided(collision):
	var _changed = self._on_collided_change_scene(collision)

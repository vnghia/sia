extends Node2D


func _ready():
	var _err = Character_Globals.CharacterNode.connect("collided", self, "_on_Character_collided")
	var scenes = World_Globals.list_scenes
	scenes["Welcome"]["instance"] = load(scenes["Welcome"]["res"]).instance()
	self.add_child(scenes["Welcome"]["instance"], true)
	World_Globals.current_scene = "Welcome"

func _on_collided_change_scene(collision: KinematicCollision2D, direction: Vector2):
	if direction == Vector2.ZERO:
		return false
	var scenes = World_Globals.list_scenes
	var current_scene = scenes[World_Globals.current_scene]
	var current_collider = null
	for collider in current_scene["door"].keys():
		if collision.collider == get_node_or_null(collider):
			current_collider = current_scene["door"][collider]
	if ! current_collider:
		return false

	var tile_pos = collision.collider.world_to_map(collision.position)
	if direction.y < 0:
		tile_pos -= collision.normal
	var to_scene_data = current_collider.get(tile_pos)
	if ! to_scene_data:
		return false
	
	var to_scene_name = to_scene_data["to"]
	self.remove_child(current_scene["instance"])
	var to_scene = scenes[to_scene_name]
	if to_scene["instance"] == null:
		to_scene["instance"] = load(to_scene["res"]).instance()
	self.add_child(to_scene["instance"])
	World_Globals.current_scene = to_scene_name
	return true

func _on_Character_collided(collision: KinematicCollision2D, direction: Vector2):
	var _changed = self._on_collided_change_scene(collision, direction)

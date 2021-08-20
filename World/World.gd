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
	var scene = scenes[World_Globals.current_scene]
	var instance = scene["instance"]
	var collider = null

	for path in scene["door"].keys():
		if collision.collider == instance.get_node_or_null(path):
			collider = scene["door"][path]
	if ! collider:
		return false

	var pos = collision.collider.world_to_map(collision.position)
	if direction.y < 0:
		pos -= collision.normal
	var destination_data = collider.get(pos)
	if ! destination_data:
		return false

	var destination_name = destination_data["to"]
	var destination = scenes[destination_name]
	if destination["instance"] == null:
		destination["instance"] = load(destination["res"]).instance()

	self.remove_child(instance)
	self.add_child(destination["instance"], true)
	World_Globals.current_scene = destination_name
	return true

func _on_Character_collided(collision: KinematicCollision2D, direction: Vector2):
	var _changed = self._on_collided_change_scene(collision, direction)

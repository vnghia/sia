extends Node2D


func _ready():
	World_Globals.rng.randomize()
	World_Globals.world_node = self
	var _err = Player_Globals.player_node.connect("collided", self, "_on_Character_collided")
	var scenes = World_Globals.list_scenes
	scenes["Welcome"]["instance"] = load(scenes["Welcome"]["res"]).instance()
	self.add_child(scenes["Welcome"]["instance"], true)
	World_Globals.current_scene = "Welcome"
	World_Globals.dialog_system = get_node("/root/Root/Dialog")


func _move_character_on_tilemap(
	destination: Node, destination_data: Dictionary, character: KinematicBody2D
):
	var tile_map = destination.get_node(destination_data["map"])
	var world_pos = World_Globals.map_to_world_center(
		tile_map,
		destination_data["pos"],
		destination_data.get("center_x"),
		destination_data.get("center_y")
	)
	character.position = world_pos


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
	self._move_character_on_tilemap(
		destination["instance"], destination_data, Player_Globals.player_node
	)
	World_Globals.current_scene = destination_name
	return true


func _on_Character_collided(collision: KinematicCollision2D, direction: Vector2):
	var changed = self._on_collided_change_scene(collision, direction)
	if changed and self.has_node("MentalBot"):
		self.remove_child(MentalBot_Globals.mentalbot_node)

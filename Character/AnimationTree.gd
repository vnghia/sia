extends AnimationTree


func _get_root_meta(key: String, default):
	var root = self.get_parent()
	if root.has_meta(key):
		return root.get_meta(key)
	else:
		return default


func _add_blend_point(space: AnimationNodeBlendSpace2D, animation: String, pos: Vector2) -> void:
	var point = AnimationNodeAnimation.new()
	point.animation = animation
	space.add_blend_point(point, pos)


func _ready():
	var sprite_metadata = self._get_root_meta(
		Character_Globals.SPRITE_METADATA_KEY, Character_Globals.SPRITE_METADATA
	)
	self.tree_root = AnimationNodeStateMachine.new()

	for sprite_name in sprite_metadata.keys():
		var sprite = sprite_metadata[sprite_name]

		var space_node = AnimationNodeBlendSpace2D.new()
		space_node.blend_mode = AnimationNodeBlendSpace2D.BLEND_MODE_DISCRETE
		space_node.max_space = Vector2(1, 1.1)
		space_node.min_space = Vector2(-1, -1.1)

		for movement_direction in sprite["animation"].keys():
			var movement = sprite["animation"][movement_direction]
			self._add_blend_point(space_node, sprite_name + movement_direction, movement["pos"])

		self.tree_root.add_node(sprite_name, space_node)

	for sprite_name in sprite_metadata.keys():
		var sprite = sprite_metadata[sprite_name]
		var transition = AnimationNodeStateMachineTransition.new()
		for destination_name in sprite["transitions"]:
			self.tree_root.add_transition(sprite_name, destination_name, transition)

	self.active = true
	for sprite in sprite_metadata.keys():
		var sprite_data = sprite_metadata[sprite]
		if sprite_data.get("start_node"):
			self.tree_root.set_start_node(sprite)
			self["parameters/{0}/blend_position".format([sprite])] = sprite_data["animation"]["Down"]["pos"]

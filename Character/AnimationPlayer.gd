extends AnimationPlayer


func _get_root_meta(key: String, default):
	var root = get_node(self.root_node)
	if root.has_meta(key):
		return root.get_meta(key)
	else:
		return default


func _add_frame_track(animation: Animation, node: Node, length: float, start: int, step: int) -> int:
	var pos = animation.add_track(Animation.TYPE_VALUE)
	animation.length = length
	animation.track_set_path(pos, String(node.get_path()) + ":frame")
	for i in range(step):
		animation.track_insert_key(pos, i * length / step, start + i)
	return pos


func _add_value_track_string(animation: Animation, node: String, key: String, value) -> int:
	var pos = animation.add_track(Animation.TYPE_VALUE)
	animation.track_set_path(pos, node + ":" + key)
	animation.track_insert_key(pos, 0, value)
	animation.track_insert_key(pos, animation.length, value)
	return pos


func _add_value_track(animation: Animation, node: Node, key: String, value) -> int:
	return self._add_value_track_string(animation, String(node.get_path()), key, value)


func _add_visible_animation(animation: Animation, shown_nodes: Array, hidden_nodes: Array) -> void:
	for node in shown_nodes:
		var _pos = _add_value_track(animation, node, "visible", true)
	for node in hidden_nodes:
		var _pos = _add_value_track(animation, node, "visible", false)


func _get_sibling_node(node_name: String) -> Node:
	return get_node(String(self.root_node) + "/" + node_name)


func _ready():
	var sprite_metadata = self._get_root_meta(
		Character_Globals.SPRITE_METADATA_KEY, Character_Globals.SPRITE_METADATA
	)
	for sprite_name in sprite_metadata.keys():
		var sprite = sprite_metadata[sprite_name]
		var sprite_node = self._get_sibling_node(sprite_name)
		sprite_node.hframes = sprite["hframes"]
		sprite_node.vframes = sprite["vframes"]

		for movement_direction in sprite["animation"].keys():
			var movement = sprite["animation"][movement_direction]

			var animation_node = Animation.new()
			animation_node.loop = true
			var _err = self.add_animation(sprite_name + movement_direction, animation_node)

			var _pos = self._add_frame_track(
				animation_node, sprite_node, movement["length"], movement["start"], movement["step"]
			)

			var hidden_nodes = []
			for hidden_sprite_name in movement["hide"]:
				hidden_nodes.append(self._get_sibling_node(hidden_sprite_name))
			var shown_nodes = []
			for shown_sprite_name in movement["show"]:
				shown_nodes.append(self._get_sibling_node(shown_sprite_name))
			self._add_visible_animation(animation_node, shown_nodes, hidden_nodes)

			var other_animations = movement["other"]
			for other_animation_name in other_animations.keys():
				var other_animation = other_animations[other_animation_name]
				var other_node = self._get_sibling_node(other_animation_name)

				for other_key in other_animation.keys():
					var _other_pos = self._add_value_track(
						animation_node, other_node, other_key, other_animation[other_key]
					)

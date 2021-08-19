extends AnimationPlayer

const PREFIX_PATH = "../"

func __add_frame_track(animation: Animation, node: Node, length: float, start: int, step: int):
	var pos = animation.add_track(Animation.TYPE_VALUE)
	animation.length = length
	animation.track_set_path(pos, String(node.get_path()) + ":frame")
	for i in range(step):
		animation.track_insert_key(pos, i * length/step, start + i)
	return pos

func __add_value_track_string(animation: Animation, node: String, key: String, value):
	var pos = animation.add_track(Animation.TYPE_VALUE)
	animation.track_set_path(pos, node + ":" + key)
	animation.track_insert_key(pos, 0, value)
	animation.track_insert_key(pos, animation.length, value)
	return pos

func __add_value_track(animation: Animation, node: Node, key: String, value):
	return self.__add_value_track_string(animation, String(node.get_path()), key, value)

func __add_visible_animation(animation: Animation, shown_nodes: Array, hidden_nodes: Array):
	for node in shown_nodes:
		var _pos = __add_value_track(animation, node, "visible", true)
	for node in hidden_nodes:
		var _pos = __add_value_track(animation, node, "visible", false)
	
func _enter_tree():
	for sprite in Character_Globals.SPRITE_METADATA.keys():
		var sprite_data = Character_Globals.SPRITE_METADATA[sprite]
		var node = get_node(PREFIX_PATH + sprite)
		node.hframes = sprite_data["hframes"]
		node.vframes = sprite_data["vframes"]
		
		for movement in sprite_data["animation"].keys():
			var movement_data = sprite_data["animation"][movement]

			var animation = Animation.new()
			animation.loop = true
			var _err = self.add_animation(sprite + movement, animation)

			self.__add_frame_track(animation, node, movement_data["length"], movement_data["start"], movement_data["step"])

			var hidden_nodes = []
			for hidden_sprite in movement_data["hide"]:
				hidden_nodes.append(get_node(PREFIX_PATH + hidden_sprite))
			var shown_nodes = []
			for shown_sprite in movement_data["show"]:
				shown_nodes.append(get_node(PREFIX_PATH + shown_sprite))
			self.__add_visible_animation(animation, [node], hidden_nodes)

			var other_animations = movement_data["other"]
			for other_node in other_animations.keys():
				var other_node_data = other_animations[other_node]
				var other_node_instance = get_node(PREFIX_PATH + other_node)

				for other_key in other_node_data.keys():
					var _pos = self.__add_value_track(animation, other_node_instance, other_key, other_node_data[other_key])

extends AnimationTree

func __add_blend2d(animations: Array):
	var space = AnimationNodeBlendSpace2D.new()
	for animation in animations:
		var point = AnimationNodeAnimation.new()
		point.animation = animation["name"]
		space.add_blend_point(point, animation["pos"])
	space.blend_mode = space.BLEND_MODE_DISCRETE
	space.max_space = Vector2(1, 1.1)
	space.min_space = Vector2(-1, -1.1)
	return space

func __add_blend_point(space: AnimationNodeBlendSpace2D, animation: String, pos: Vector2):
	var point = AnimationNodeAnimation.new()
	point.animation = animation
	space.add_blend_point(point, pos)

func _enter_tree():
	for sprite in Character_Globals.SPRITE_METADATA.keys():
		var sprite_data = Character_Globals.SPRITE_METADATA[sprite]

		var space = AnimationNodeBlendSpace2D.new()
		space.blend_mode = AnimationNodeBlendSpace2D.BLEND_MODE_DISCRETE
		space.max_space = Vector2(1, 1.1)
		space.min_space = Vector2(-1, -1.1)

		for movement in sprite_data["animation"].keys():
			var movement_data = sprite_data["animation"][movement]
			self.__add_blend_point(space, sprite + movement, movement_data["pos"])

		self.tree_root.add_node(sprite, space)
	
	for sprite in Character_Globals.SPRITE_METADATA.keys():
		var sprite_data = Character_Globals.SPRITE_METADATA[sprite]
		var transition = AnimationNodeStateMachineTransition.new()
		for transition_node in sprite_data["transitions"]:
			self.tree_root.add_transition(sprite, transition_node, transition)

func _ready():
	self.active = true
	for sprite in Character_Globals.SPRITE_METADATA.keys():
		var sprite_data = Character_Globals.SPRITE_METADATA[sprite]
		if sprite_data.get("start_node"):
			self.tree_root.set_start_node(sprite)
			self["parameters/{0}/blend_position".format([sprite])] = sprite_data["animation"]["Down"]["pos"]

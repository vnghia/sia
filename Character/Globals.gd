extends Node

const SPRITE_METADATA = {
	"Idle":
	{
		"hframes": 24,
		"vframes": 1,
		"animation":
		{
			"Right":
			{
				"length": 0.6,
				"start": 0,
				"step": 6,
				"pos": Vector2(1, 0),
				"show": ["Idle"],
				"hide": ["Run"],
				"other": {"Collision": {"rotation_degrees": 180}}
			},
			"Up":
			{
				"length": 0.6,
				"start": 6,
				"step": 6,
				"pos": Vector2(0, -1.1),
				"show": ["Idle"],
				"hide": ["Run"],
				"other": {"Collision": {"rotation_degrees": 270}}
			},
			"Left":
			{
				"length": 0.6,
				"start": 12,
				"step": 6,
				"pos": Vector2(-1, 0),
				"show": ["Idle"],
				"hide": ["Run"],
				"other": {"Collision": {"rotation_degrees": 0}}
			},
			"Down":
			{
				"length": 0.6,
				"start": 18,
				"step": 6,
				"pos": Vector2(0, 1.1),
				"show": ["Idle"],
				"hide": ["Run"],
				"other": {"Collision": {"rotation_degrees": 90}}
			},
		},
		"transitions": ["Run"],
		"start_node": true
	},
	"Run":
	{
		"hframes": 24,
		"vframes": 1,
		"animation":
		{
			"Right":
			{
				"length": 0.6,
				"start": 0,
				"step": 6,
				"pos": Vector2(1, 0),
				"show": ["Run"],
				"hide": ["Idle"],
				"other": {"Collision": {"rotation_degrees": 180}}
			},
			"Up":
			{
				"length": 0.6,
				"start": 6,
				"step": 6,
				"pos": Vector2(0, -1.1),
				"show": ["Run"],
				"hide": ["Idle"],
				"other": {"Collision": {"rotation_degrees": 270}}
			},
			"Left":
			{
				"length": 0.6,
				"start": 12,
				"step": 6,
				"pos": Vector2(-1, 0),
				"show": ["Run"],
				"hide": ["Idle"],
				"other": {"Collision": {"rotation_degrees": 0}}
			},
			"Down":
			{
				"length": 0.6,
				"start": 18,
				"step": 6,
				"pos": Vector2(0, 1.1),
				"show": ["Run"],
				"hide": ["Idle"],
				"other": {"Collision": {"rotation_degrees": 90}}
			},
		},
		"transitions": ["Idle"],
	}
}

const SPRITE_METADATA_KEY = "sprite_metadata"


func new_npc(idle: Resource, run: Resource, pos: Vector2):
	var npc = preload("res://Character/NPC/NPC.tscn").instance()
	npc.get_node("Idle").texture = idle
	npc.get_node("Run").texture = run
	npc.position = pos
	return npc


const LIST_CHARACTER_NAME_RES = {
	"Alex": null,
	"Amelia": null,
	"Ash": null,
	"Bob": null,
	"Bouncer": null,
	"Bruce": null,
	"Butcher": null,
	"Butcher_2": null,
	"Chef_Alex": null,
	"Chef_Lucy": null,
	"Chef_Molly": null,
	"Chef_Pier": null,
	"Chef_Rob": null,
	"Conference_man": null,
	"Conference_woman": null,
	"Dan": null,
	"Doctor_1": null,
	"Doctor_2": null,
	"Edward": null,
	"Fishmonger_1": null,
	"Fishmonger_2": null,
	"Halloween_Kid_1": null,
	"Halloween_Kid_2": null,
	"Kid_Abby": null,
	"Kid_Karen": null,
	"Kid_Mitty": null,
	"Kid_Romeo": null,
	"Kid_Tim": null,
	"Lucy": null,
	"Molly": null,
	"Nurse_1": null,
	"Nurse_2": null,
	"Old_man_Josh": null,
	"Old_woman_Jenny": null,
	"Pier": null,
	"Prisoner_1": null,
	"Prisoner_2": null,
	"Prisoner_3": null,
	"Rob": null,
	"Roki": null,
	"Samuel": null,
	"kid_Oscar": null
}


func get_random_character_res():
	var name_idx = World_Globals.rng.randi_range(0, LIST_CHARACTER_NAME_RES.size() - 1)
	var name = LIST_CHARACTER_NAME_RES.keys()[name_idx]
	if ! LIST_CHARACTER_NAME_RES[name]:
		LIST_CHARACTER_NAME_RES[name] = {
			"idle": load("res://Character/Character/{0}_idle_anim_48x48.png".format([name])),
			"run": load("res://Character/Character/{0}_run_48x48.png".format([name]))
		}
	return LIST_CHARACTER_NAME_RES[name]


func gen_random_npcs(num_npc: int, tile_map: TileMap, tile_set_idx: int):
	var npcs = []
	for _i in range(num_npc):
		var res = get_random_character_res()
		var npc = new_npc(
			res["idle"],
			res["run"],
			World_Globals.get_random_world_position_on_tilemap(tile_map, tile_set_idx, true, true)
		)
		npcs.append(npc)
	return npcs


func move_and_anim(
	body: KinematicBody2D,
	method: String,
	input_vector: Vector2,
	velocity: Vector2,
	delta: float,
	speed: float,
	acceleration: float,
	friction: float
):
	var sprite_metadata = Character_Globals.SPRITE_METADATA
	if body.has_meta(Character_Globals.SPRITE_METADATA_KEY):
		sprite_metadata = body.get_meta(Character_Globals.SPRITE_METADATA_KEY)
	var sprites = sprite_metadata.keys()
	var animation_tree = body.get_node("AnimationTree")
	var animation_state = animation_tree.get("parameters/playback")
	if input_vector != Vector2.ZERO:
		for sprite in sprites:
			animation_tree.set("parameters/{0}/blend_position".format([sprite]), input_vector)
		animation_state.travel(sprites[1])
		velocity = velocity.move_toward(input_vector * speed, acceleration * delta)
	else:
		animation_state.travel(sprites[0])
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	return body.call(method, velocity)

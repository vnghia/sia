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

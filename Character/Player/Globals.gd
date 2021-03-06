extends Node

var player_node = null

const SPRITE_METADATA = {
	"Idle":
	{
		"res": "res://Character/Player/idle.png",
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
				"other":
				{"Collision": {"rotation_degrees": 180}, "Interaction": {"rotation_degrees": 270}}
			},
			"Up":
			{
				"length": 0.6,
				"start": 6,
				"step": 6,
				"pos": Vector2(0, -1.1),
				"show": ["Idle"],
				"hide": ["Run"],
				"other":
				{"Collision": {"rotation_degrees": 270}, "Interaction": {"rotation_degrees": 180}}
			},
			"Left":
			{
				"length": 0.6,
				"start": 12,
				"step": 6,
				"pos": Vector2(-1, 0),
				"show": ["Idle"],
				"hide": ["Run"],
				"other":
				{"Collision": {"rotation_degrees": 0}, "Interaction": {"rotation_degrees": 90}}
			},
			"Down":
			{
				"length": 0.6,
				"start": 18,
				"step": 6,
				"pos": Vector2(0, 1.1),
				"show": ["Idle"],
				"hide": ["Run"],
				"other":
				{"Collision": {"rotation_degrees": 90}, "Interaction": {"rotation_degrees": 0}}
			},
		},
		"transitions": ["Run"],
		"start_node": true
	},
	"Run":
	{
		"res": "res://Character/Player/run.png",
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
				"other":
				{"Collision": {"rotation_degrees": 180}, "Interaction": {"rotation_degrees": 270}}
			},
			"Up":
			{
				"length": 0.6,
				"start": 6,
				"step": 6,
				"pos": Vector2(0, -1.1),
				"show": ["Run"],
				"hide": ["Idle"],
				"other":
				{"Collision": {"rotation_degrees": 270}, "Interaction": {"rotation_degrees": 180}}
			},
			"Left":
			{
				"length": 0.6,
				"start": 12,
				"step": 6,
				"pos": Vector2(-1, 0),
				"show": ["Run"],
				"hide": ["Idle"],
				"other":
				{"Collision": {"rotation_degrees": 0}, "Interaction": {"rotation_degrees": 90}}
			},
			"Down":
			{
				"length": 0.6,
				"start": 18,
				"step": 6,
				"pos": Vector2(0, 1.1),
				"show": ["Run"],
				"hide": ["Idle"],
				"other":
				{"Collision": {"rotation_degrees": 90}, "Interaction": {"rotation_degrees": 0}}
			},
		},
		"transitions": ["Idle"],
	}
}

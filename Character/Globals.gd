extends Node

const SPRITE_METADATA = {
	"Idle": {
		"res": "res://Character/Adam/idle.png",
		"hframes": 24,
		"vframes": 1,
		"animation": {
			"Right": {
				"length": 0.6,
				"start": 0,
				"step": 6,
				"pos": Vector2(1, 0),
				"show": ["Idle"],
				"hide": ["Run"],
			},
			"Up": {
				"length": 0.6,
				"start": 6,
				"step": 6,
				"pos": Vector2(0, -1.1),
				"show": ["Idle"],
				"hide": ["Run"],
			},
			"Left": {
				"length": 0.6,
				"start": 12,
				"step": 6,
				"pos": Vector2(-1, 0),
				"show": ["Idle"],
				"hide": ["Run"],
			},
			"Down": {
				"length": 0.6,
				"start": 18,
				"step": 6,
				"pos": Vector2(0, 1.1),
				"show": ["Idle"],
				"hide": ["Run"],
			},
		},
		"transitions": ["Run"],
		"start_node": true
	},
	"Run": {
		"res": "res://Character/Adam/run.png",
		"hframes": 24,
		"vframes": 1,
		"animation": {
			"Right": {
				"length": 0.6,
				"start": 0,
				"step": 6,
				"pos": Vector2(1, 0),
				"show": ["Run"],
				"hide": ["Idle"],
			},
			"Up": {
				"length": 0.6,
				"start": 6,
				"step": 6,
				"pos": Vector2(0, -1.1),
				"show": ["Run"],
				"hide": ["Idle"],
			},
			"Left": {
				"length": 0.6,
				"start": 12,
				"step": 6,
				"pos": Vector2(-1, 0),
				"show": ["Run"],
				"hide": ["Idle"],
			},
			"Down": {
				"length": 0.6,
				"start": 18,
				"step": 6,
				"pos": Vector2(0, 1.1),
				"show": ["Run"],
				"hide": ["Idle"],
			},
		},
		"transitions": ["Idle"],
	}
}

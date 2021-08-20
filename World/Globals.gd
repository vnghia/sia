extends Node

var list_scenes = {
	"Welcome": {
		"res": "res://World/Welcome/Welcome.tscn",
		"instance": null,
		"door": {
			"Welcome/Entry": {
				Vector2(1, 0): {
					"to": "OfficeHall",
				},
				Vector2(3, 0): {
					"to": "Cafeteria",
				}
			}
		}
	},
	"OfficeHall": {
		"res": "res://World/OfficeHall/OfficeHall.tscn",
		"instance": null,
		"door": {
			"OfficeHall/Exit": {
				Vector2(8, 6): {
					"to": "Welcome",
				}
			},
			"OfficeHall/Door": {
				Vector2(8, 0): {
					"to": "Office"
				}
			}
		}
	},
	"Office": {
		"res": "res://World/Office/Office.tscn",
		"instance": null,
		"door": {
			"Office/Exit": {
				Vector2(17, 30): {
					"to": "OfficeHall",
				},
				Vector2(18, 30): {
					"to": "OfficeHall",
				},
			}
		}
	},
	"Cafeteria": {
		"res": "res://World/Cafeteria/Cafeteria.tscn",
		"instance": null,
		"door": {
			"Cafeteria/Exit": {
				Vector2(5, 13): {
					"to": "Welcome",
				},
				Vector2(6, 13): {
					"to": "Welcome",
				},
			}
		}
	}
}

var current_scene = null

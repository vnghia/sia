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
				},
			}
		}
	}
}

var current_scene = null

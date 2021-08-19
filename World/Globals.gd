extends Node

var list_scenes = {
	"Welcome": {
		"res": "res://World/Welcome/Welcome.tscn",
		"instance": null,
		"door": {
			"Welcome/Entry": {
				"Entryway_Office": {
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
				"Exit": {
					"to": "Welcome",
				},
			}
		}
	}
}

var current_scene = null

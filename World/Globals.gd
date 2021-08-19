extends Node

var list_scenes = {
	"Welcome": {
		"res": "res://World/Welcome/Welcome.tscn",
		"instance": null,
		"door": {
			"Welcome/Entry": {
				"Entryway_Office": {
					"to": "OfficeHall",
					"normal": true
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
					"normal": false
				},
			}
		}
	}
}

var current_scene = null

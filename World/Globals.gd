extends Node

var list_scenes = {
	"Welcome":
	{
		"res": "res://World/Welcome/Welcome.tscn",
		"instance": null,
		"door":
		{
			"Entry":
			{
				Vector2(1, 0):
				{
					"to": "OfficeHall",
					"map": "Exit",
					"pos": Vector2(8, 4),
					"center_x": true,
				},
				Vector2(3, 0): {"to": "Cafeteria", "map": "Exit", "pos": Vector2(6, 11)}
			}
		}
	},
	"OfficeHall":
	{
		"res": "res://World/OfficeHall/OfficeHall.tscn",
		"instance": null,
		"door":
		{
			"Exit":
			{
				Vector2(8, 6):
				{
					"to": "Welcome",
					"map": "Entry",
					"pos": Vector2(1, 1),
					"center_x": true,
				}
			}
		}
	},
	"Office":
	{
		"res": "res://World/Office/Office.tscn",
		"instance": null,
		"door":
		{
			"Exit":
			{
				Vector2(17, 30):
				{
					"to": "OfficeHall",
				},
				Vector2(18, 30):
				{
					"to": "OfficeHall",
				},
			}
		}
	},
	"Cafeteria":
	{
		"res": "res://World/Cafeteria/Cafeteria.tscn",
		"instance": null,
		"door":
		{
			"Exit":
			{
				Vector2(5, 13):
				{
					"to": "Welcome",
					"map": "Entry",
					"pos": Vector2(3, 1),
					"center_x": true,
				},
				Vector2(6, 13):
				{
					"to": "Welcome",
					"map": "Entry",
					"pos": Vector2(3, 1),
					"center_x": true,
				},
			}
		}
	}
}

var current_scene = null
var dialog_system = null

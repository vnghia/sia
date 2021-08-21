extends Node

var rng = RandomNumberGenerator.new()

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

# warning-ignore:unused_signal
signal change_listener(node)


func map_to_world_center(tile_map: TileMap, pos: Vector2, center_x, center_y):
	var cell_size = tile_map.cell_size
	var world_pos = tile_map.map_to_world(pos)
	if center_x:
		world_pos.x += cell_size.x / 2
	if center_y:
		world_pos.y -= cell_size.y / 2
	return world_pos


func get_random_world_position_on_tilemap(tile_map: TileMap, tile_set_idx: int, center_x, center_y):
	var cells = tile_map.get_used_cells_by_id(tile_set_idx)
	var cell_idx = rng.randi_range(0, cells.size() - 1)
	var pos = cells[cell_idx]
	return self.map_to_world_center(tile_map, pos, center_x, center_y)

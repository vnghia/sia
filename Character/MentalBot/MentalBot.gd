extends KinematicBody2D


func _ready():
	$Idle.texture = load("res://Character/MentalBot/idle.png")
	$Run.texture = load("res://Character/MentalBot/run.png")
	self.position = Vector2(self.get_viewport().size.x / 2, self.get_viewport().size.y / 2)

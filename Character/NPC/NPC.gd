extends KinematicBody2D


func _init():
	self.set_meta("name", "NPC")


func _ready():
	$Idle.texture = load("res://Character/Adam/idle.png")
	$Run.texture = load("res://Character/Adam/run.png")
	self.position = Vector2(self.get_viewport().size.x / 2, self.get_viewport().size.y / 2)

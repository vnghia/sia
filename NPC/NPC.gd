extends KinematicBody2D


func _ready():
	self.get_node("Idle").texture = load("res://Character/Adam/idle.png")
	self.get_node("Run").texture = load("res://Character/Adam/run.png")
	self.position = Vector2(self.get_viewport().size.x / 2 , self.get_viewport().size.y / 2)

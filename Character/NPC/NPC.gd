extends KinematicBody2D

const ACCELERATION = 1000
const MAX_SPEED = 100
const FRICTION = ACCELERATION

var velocity = Vector2.ZERO
var input_vector = Vector2(
	World_Globals.rng.randf_range(-1, 1), World_Globals.rng.randf_range(-1, 1)
)


func _init():
	self.set_meta("name", "NPC")


func _physics_process(delta):
	var collision = Character_Globals.move_and_anim(
		self,
		"move_and_collide",
		input_vector * delta,
		velocity,
		delta,
		MAX_SPEED,
		ACCELERATION,
		FRICTION
	)
	if collision:
		input_vector = Vector2(
			World_Globals.rng.randf_range(-1, 1), World_Globals.rng.randf_range(-1, 1)
		)

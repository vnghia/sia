extends KinematicBody2D

const ACCELERATION = 1000
const MAX_SPEED = 200
const FRICTION = ACCELERATION

var velocity = Vector2.ZERO

signal collided(collision, direction)

onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

func _init():
	Character_Globals.CharacterNode = self

func _ready():
	for sprite in Character_Globals.SPRITE_METADATA.keys():
		var sprite_data = Character_Globals.SPRITE_METADATA[sprite]
		get_node(sprite).texture = load(sprite_data["res"])
	World_Globals.list_scenes["OfficeHall"]["door"]["OfficeHall/Door"] = {
		Vector2(8, 0): {
			"to": "Office"
		}
	}

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	var sprites = Character_Globals.SPRITE_METADATA.keys()
	if input_vector != Vector2.ZERO:
		for sprite in sprites:
			animation_tree.set("parameters/{0}/blend_position".format([sprite]), input_vector)
		animation_state.travel(sprites[1])
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animation_state.travel(sprites[0])
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)

	for i in self.get_slide_count():
		var collision = self.get_slide_collision(i)
		if collision:
			self.emit_signal("collided", collision, input_vector)

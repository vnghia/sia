extends KinematicBody2D

const ACCELERATION = 1000
const MAX_SPEED = 200
const FRICTION = ACCELERATION

var velocity = Vector2.ZERO
var interactable_node = null

signal collided(collision, direction)

onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")


func _init():
	self.set_meta("name", "Player")
	Player_Globals.player_node = self
	self.set_meta(Character_Globals.SPRITE_METADATA_KEY, Player_Globals.SPRITE_METADATA)


func _ready():
	var _err = $Interaction.connect("body_entered", self, "_on_Interaction_body_entered")
	_err = $Interaction.connect("body_exited", self, "_on_Interaction_body_exited")
	_err = World_Globals.connect("change_listener", self, "_on_change_listener")
	World_Globals.emit_signal("change_listener", null, self)
	$Camera.remote_path = "/root/Root/Camera"

	var sprite_metadata = self.get_meta(Character_Globals.SPRITE_METADATA_KEY)
	for sprite in sprite_metadata.keys():
		var sprite_data = sprite_metadata[sprite]
		get_node(sprite).texture = load(sprite_data["res"])
	World_Globals.list_scenes["OfficeHall"]["door"]["Door"] = {
		Vector2(8, 0): {"to": "Office", "map": "Exit", "pos": Vector2(18, 28)}
	}
	World_Globals.list_scenes["Office"]["door"]["Exit"][Vector2(17, 30)]["map"] = "Door"
	World_Globals.list_scenes["Office"]["door"]["Exit"][Vector2(17, 30)]["pos"] = Vector2(8, 1)
	World_Globals.list_scenes["Office"]["door"]["Exit"][Vector2(17, 30)]["center_x"] = true
	World_Globals.list_scenes["Office"]["door"]["Exit"][Vector2(18, 30)]["map"] = "Door"
	World_Globals.list_scenes["Office"]["door"]["Exit"][Vector2(18, 30)]["pos"] = Vector2(8, 1)
	World_Globals.list_scenes["Office"]["door"]["Exit"][Vector2(18, 30)]["center_x"] = true


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		if interactable_node and interactable_node.has_method("interact"):
			interactable_node.interact()
	elif event.is_action_pressed("ui_select"):
		get_node("/root/Root/HUD/Menu").visible = ! get_node("/root/Root/HUD/Menu").visible


func _get_input_vector():
	var input_vector = Vector2.ZERO
	input_vector.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	return input_vector.normalized()


func _physics_process(delta):
	var input_vector = self._get_input_vector()
	velocity = Character_Globals.move_and_anim(
		self, "move_and_slide", input_vector, velocity, delta, MAX_SPEED, ACCELERATION, FRICTION
	)

	for i in self.get_slide_count():
		var collision = self.get_slide_collision(i)
		if collision:
			self.emit_signal("collided", collision, input_vector)


func _on_Interaction_body_entered(body: Node):
	if body == self:
		return
	interactable_node = body


func _on_Interaction_body_exited(_body: Node):
	interactable_node = null


func _on_change_listener(_old: Node, new: Node):
	if new != self:
		self.set_process(false)
		self.set_physics_process(false)
		self.set_process_unhandled_input(false)
	else:
		self.set_process(true)
		self.set_physics_process(true)
		self.set_process_unhandled_input(true)

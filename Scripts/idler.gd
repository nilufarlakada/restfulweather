class_name Idler extends CharacterBody2D

var cardinal_dir: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: StateMachine = $StateMachine

signal DirectionChanged(newDirection: Vector2)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine.Initialize(self)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	#direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	#direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()
	
	pass

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _check_direction() -> bool:
	var new_dir : Vector2 = cardinal_dir
	
	if direction == Vector2.ZERO:
		return false
	
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
	
	if new_dir == cardinal_dir:
		return false
		
	cardinal_dir = new_dir
	
	DirectionChanged.emit(cardinal_dir)
	
	sprite.scale.x = -1 if cardinal_dir == Vector2.LEFT else 1
	
	return true

func _update_animation(state:String) -> void:
	animation_player.play(state + "_" + _get_direction())
	pass

func _update_animationcutscenes(state: String, dir: String, _side: Vector2) -> void:
	match state:
		"idle":
			if dir != "side":
				animation_player.play("idle_"+ dir)
			else:
				if _side == Vector2.LEFT:
					direction = Vector2.LEFT
					animation_player.play("idle_"+ "side")
				else:
					direction = Vector2.RIGHT
					animation_player.play("idle_"+ "side")
		"walk":
			if dir != "side":
				animation_player.play("walk_"+ dir)
			else:
				if _side == Vector2.LEFT:
					direction = Vector2.LEFT
					animation_player.play("walk_"+ "side")
				else:
					direction = Vector2.RIGHT
					animation_player.play("walk_"+ "side")
	pass

func _get_direction() -> String:
	
	if cardinal_dir == Vector2.DOWN:
		return "down"
	elif cardinal_dir == Vector2.UP:
		return "up"
	else:
		return "side"

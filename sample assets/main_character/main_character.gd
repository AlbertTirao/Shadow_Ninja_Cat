extends CharacterBody2D


const SPEED = 200.0
const SPRINT_SPEED = 500.0
const DASH_SPEED = 800.0
const JUMP_VELOCITY = -600.0
const DASH_DURATION = 0.2
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

var can_double_jump = false
var is_dashing = false
var dash_timer = 0.0


func _physics_process(delta: float) -> void:
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing =false
		move_and_slide()
		return
		
	if (velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = "running"
	else :
		sprite_2d.animation = "default"
		 
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		sprite_2d.animation = "jumping"
	else:
		can_double_jump = true

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif can_double_jump:
			velocity.y = JUMP_VELOCITY
			can_double_jump = false
			
	var speed = SPEED
	if Input.is_action_just_pressed("sprint"):
		speed = SPRINT_SPEED

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 12)
		
	if Input.is_action_just_pressed("dash") and not is_dashing:
		is_dashing = true
		dash_timer = DASH_DURATION
		velocity.x = (1 if velocity.x > 0 else -1) * DASH_SPEED

	move_and_slide()
	
	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft

extends CharacterBody2D

var speed = 30

@onready var attack_timer = $AttackTimer
var player = null  # Will be initialized in _ready()
var randomnum

enum State {
	SURROUND,
	ATTACK,
	HIT,
}

var state = State.SURROUND

func _ready():
	# Initialize random position on circle
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	randomnum = rng.randf()
	
	# Get player reference (adjust path according to your scene structure)
	player = get_tree().get_first_node_in_group("player")
	if not player:
		printerr("Player not found!")

func _physics_process(delta):
	if not player:
		return
	
	match state:
		State.SURROUND:
			move(get_circle_position(randomnum), delta)
		State.ATTACK:
			move(player.global_position, delta)
		State.HIT:
			move(player.global_position, delta)
			print("HIT")
			# Add hit animation logic here

func move(target, delta):
	var direction = (target - global_position).normalized()
	var desired_velocity = direction * speed
	var steering = (desired_velocity - velocity) * delta * 2.5
	velocity += steering
	velocity = move_and_slide()

func get_circle_position(random):
	var radius = 40
	var angle = random * PI * 2
	return player.global_position + Vector2(cos(angle), sin(angle)) * radius

func _on_attack_timer_timeout():
	state = State.ATTACK

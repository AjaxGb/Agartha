extends CharacterBody2D

@export var walk_speed := 150.0
@export var run_speed := 250.0

@onready var aim_node := $AimRotation

func _process(delta):
	var local_mouse_pos := get_local_mouse_position()
	if local_mouse_pos:
		aim_node.rotation = local_mouse_pos.angle()

func _physics_process(delta):
	var direction := Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	var speed := run_speed if Input.is_action_pressed("sprint") else walk_speed

	if direction:
		velocity = direction * speed
	else:
		velocity = velocity.move_toward(Vector2(), speed)
	
	if Input.is_action_pressed("fire_main"):
		var space_state := get_world_2d().direct_space_state
		
		var aim_to := get_local_mouse_position()
		if aim_to.length_squared() >= 0.01:
			aim_to = aim_to.normalized() * 1000.0
		else:
			aim_to = Vector2.from_angle(global_rotation) * 1000.0
		
		# use global coordinates, not local to node
		var query = PhysicsRayQueryParameters2D.create(global_position, aim_to)
		var result = space_state.intersect_ray(query)
		

	move_and_slide()

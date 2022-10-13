extends Camera2D


export (int) var speed = 200
export (int) var ScreenScrollspeed = 200
export (int) var screenScrollDistance = 5

var velocity := Vector2()
var scrollVelocity := Vector2()

func _physics_process(delta):
	get_input()
	var move_vector = velocity + scrollVelocity
	self.transform = self.transform.translated(move_vector*delta)

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("Camera_right"):
		velocity.x += 1
	if Input.is_action_pressed("Camera_left"):
		velocity.x -= 1
	if Input.is_action_pressed("Camera_down"):
		velocity.y += 1
	if Input.is_action_pressed("Camera_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	
func _input(event):

	if event is InputEventMouseMotion:
		var windowSize = OS.get_window_size()
		scrollVelocity = Vector2()
		if event.position.x < screenScrollDistance:
			scrollVelocity.x += (event.position.x - screenScrollDistance)/screenScrollDistance
		if event.position.y < screenScrollDistance:
			scrollVelocity.y += (event.position.y - screenScrollDistance)/screenScrollDistance
		if event.position.x > windowSize.x - screenScrollDistance:
			scrollVelocity.x -= (event.position.x - windowSize.x - screenScrollDistance)/screenScrollDistance
		if event.position.y > windowSize.y - screenScrollDistance:
			scrollVelocity.y -= (event.position.y - windowSize.y - screenScrollDistance)/screenScrollDistance
			
		scrollVelocity = scrollVelocity * speed
		#scrollVelocity = scrollVelocity.normalized() * speed
		
		
func _notification(blah):
	match blah:
		NOTIFICATION_WM_MOUSE_EXIT:
			scrollVelocity = Vector2()

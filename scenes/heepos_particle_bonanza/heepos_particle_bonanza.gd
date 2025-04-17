extends Node2D

@export var refresh_steps = 4
@export var refresh_pct = 0.75

@export var n_click_particles = 128
@export var particle_speed = 75
@export var particle_speed_variance = 25
@export var particle_lifetime = 0.75
@export var particle_gravity = 150

class Particle:
	var pos: Vector2
	var vel: Vector2
	var t: float

var particles: Array = []
var image: Image
var refresh_idx = 0

func _ready() -> void:
	var win = get_tree().current_scene.get_window()
	var s = Vector2(win.size) / $ParticleSprite.scale
	image = Image.create_empty(s.x, s.y, false, Image.Format.FORMAT_RGBA8)
	var p = Particle.new()
	p.pos = Vector2(100, 100)
	p.vel = Vector2(50, 50)
	p.t = particle_lifetime
	particles.append(p)
	$ParticleSprite.texture = ImageTexture.create_from_image(image)

func _process(dt: float) -> void:
	# fade previously drawn pixels
	var slice_size = image.get_width()/refresh_steps
	for x in range(slice_size):
		x += refresh_idx*slice_size
		for y in range(image.get_height()):
			var c = image.get_pixel(x, y)
			c.a *= refresh_pct
			image.set_pixel(x, y, c)
	refresh_idx += 1
	if refresh_idx >= refresh_steps:
		refresh_idx = 0

	# update particle positions
	var to_remove = []
	for i in range(particles.size()):
		var p = particles[i]
		p.pos += p.vel*dt
		var r = p.pos
		if (r.x >= 0 and r.x < image.get_width() and
				r.y >= 0 and r.y < image.get_height()):
			image.set_pixel(r.x, r.y, Color.WHITE)
		p.t -= dt
		if p.t <= 0:
			if i == 0:
				# one special-case for a demo can't hurt...
				p.t = particle_lifetime
				p.pos = Vector2(200*randf()+100, 100)
			else:
				to_remove.append(i)
	for i in to_remove:
		# this is O(n^2)... fix if we care
		particles.remove_at(i)

	# update drawn texture
	$ParticleSprite.texture = ImageTexture.create_from_image(image)
	#if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		# 1.3.3.7 Haiku.Matrix

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		for i in range(n_click_particles):
			var p = Particle.new()
			p.pos = event.position / $ParticleSprite.scale
			var spd = randf()*particle_speed_variance + particle_speed
			p.vel = Vector2.from_angle(randf()*TAU) * spd
			p.t = particle_lifetime
			particles.append(p)

extends Node2D

const REEL_SPEED = 16.0

var angle: float = -PI / 2.0
var line_tension: float = 0.5

func set_tension(value: float) -> void:
    line_tension = clampf(value, 0.0, 1.0)

func add_tension(amount: float) -> void:
    set_tension(line_tension + amount)

func reel(target: Vector2, delta: float) -> void:
    var new_angle := lerp_angle(angle, Vector2.RIGHT.angle_to_point(target), REEL_SPEED * delta)
    if new_angle > angle:
        add_tension((new_angle - angle) * 1.0 * delta)
        angle = new_angle

func _process(delta: float) -> void:
    add_tension(-0.01 * delta)
    $Reel/Line2D.points[-1] = ($Reel.position * 2.0) * Vector2.RIGHT.rotated(angle)
    $TextureRect/tension.set_position(Vector2(clampf(63.0 * (line_tension * 2), 4.0, 124.0), 0.0))
    if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
        reel(get_global_mouse_position() - $Reel.position, delta)
        

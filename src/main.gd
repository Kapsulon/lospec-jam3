extends Node

var fishing: bool = false



func set_reeling(toggle: bool) -> void:
    $UI/Reel.line_tension = 0.5
    $UI/Reel.set_process(toggle)
    $UI/Reel.set_visible(toggle)
    fishing = toggle
    if fishing == false:
        $UI/cast.show()


func _ready() -> void:
    set_reeling(false)


func _process(delta: float) -> void:
    $UI/debug_fishing.text = "Fishing: %s" % ["true" if fishing else "false"]
    if fishing:
        if $UI/Reel.line_tension < 0.25 or $UI/Reel.line_tension > 0.75:
            var error: float = absf($UI/Reel.line_tension - 0.5) * randf_range(0.3, 0.7) * delta
            if error > randf_range(0.0, 1.0):
                set_reeling(false)
            


func _on_cast_pressed() -> void:
    $UI/cast.hide()
    await get_tree().create_timer(randf_range(1.0, 3.0)).timeout
    set_reeling(true)

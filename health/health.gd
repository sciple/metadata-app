extends GraphNode


# Called when the node enters the scene tree for the first time.
func _ready():
	var timestamp = Time.get_datetime_string_from_system()
	$date.text = timestamp

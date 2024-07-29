extends Control

func _ready():
	var timestamp = Time.get_datetime_string_from_system()
	$entry_date.text = timestamp

extends Button

var parent

func _ready():
	parent = (get_parent())

func _on_pressed():
	parent.get_node("FileDialog").visible=true

func _on_file_dialog_file_selected(path):
	parent.get_node("raw_data_path").text = path

extends GraphNode


func _on_find_raw_data_pressed():
	$FileDialog.visible=true


func _on_file_dialog_file_selected(path):
	$raw_data_path.text = path

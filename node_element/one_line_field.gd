extends LineEdit

## for debuggining : uncomment this
#func _ready():
	#print("attempt color change)")
	#change_color()
	
func change_color():
	var new_stylebox_normal = self.get_theme_stylebox("normal").duplicate()
	new_stylebox_normal.border_width_top = 3
	new_stylebox_normal.border_color = Color(0, 1, 0.5)
	self.add_theme_stylebox_override("normal", new_stylebox_normal)
	
	# Remove the stylebox override.
	#$MyButton.remove_theme_stylebox_override("normal")
	#self.add_theme_stylebox_override("bg_color",Color(1, 0.5, 0))

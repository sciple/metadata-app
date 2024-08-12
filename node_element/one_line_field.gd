extends LineEdit

## for debugging: uncomment this
#func _ready():
	#print("attempt color change)")
	#change_color()

func change_color(selection_color):
	var new_stylebox_normal = self.get_theme_stylebox("normal").duplicate()
	new_stylebox_normal.bg_color = selection_color
	set("theme_override_colors/font_color",Color(1,1,1))
	#new_stylebox_normal.font_color = Color(1,1,1)
	self.add_theme_stylebox_override("normal", new_stylebox_normal)

func revert_color():
	var new_stylebox_normal = self.get_theme_stylebox("normal").duplicate()
	new_stylebox_normal.bg_color = Color(1,1,1)
	set("theme_override_colors/font_color",Color(0,0,0))
	self.add_theme_stylebox_override("normal", new_stylebox_normal)

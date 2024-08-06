extends LineEdit

## for debugging: uncomment this
#func _ready():
	#print("attempt color change)")
	#change_color()

func change_color():
	var new_stylebox_normal = self.get_theme_stylebox("normal").duplicate()
	#new_stylebox_normal.border_width_top = 2
	#new_stylebox_normal.border_width = 2
	new_stylebox_normal.bg_color = Color(Global.red_color)
	self.add_theme_stylebox_override("normal", new_stylebox_normal)

func revert_color():
	var new_stylebox_normal = self.get_theme_stylebox("normal").duplicate()
	new_stylebox_normal.bg_color = Color(1,1,1)
	self.add_theme_stylebox_override("normal", new_stylebox_normal)

#func apply_change_to_field(input_list_of_cages):
	#for i in input_list_of_cages:
		

extends "res://node_element/node_element.gd"

var n_of_subjects = 0
var cage_id

func _ready():
	Global.debug(self, self.title)

func update_title_id():
	cage_id = get_node("cage_id").text
	self.title = "Cage ID: " + cage_id + " (" + str(n_of_subjects) + ")"

func get_subjects():
	n_of_subjects = 0
	for i in range(5):
		var subject = get_node("subject_" + str(i + 1))
		if subject.text != "":
			n_of_subjects += 1
	print(n_of_subjects)
				

func change_color(treatment_list, selection_color):
	#input is list from treatment_plus node
	#check that the node is the intended recipient of the connecitons
	for con in treatment_list:
		if self.name in con["to_node"]:
			print("it is me (", self.name, ") that has to change")
			if con["to_port"] != 0:
				var subject = get_node("subject_" + str(con["to_port"]))
				subject.change_color(selection_color)
			else:
				var cage_id = get_node("cage_id")
				cage_id.change_color(selection_color)
				for i in range(1,6):
					var subject = get_node("subject_" + str(i))
					subject.change_color(selection_color)

func revert_color(treatment_list):
	print("reverting color")
	for con in treatment_list:
		if self.name in con["to_node"]:
			if con["to_port"] != 0:
				var subject = get_node("subject_" + str(con["to_port"]))
				subject.revert_color()
			else:
				var cage_id = get_node("cage_id")
				cage_id.revert_color()
				for i in range(1,6):
					var subject = get_node("subject_" + str(i))
					subject.revert_color()

#---------- update title bar upon inseritng data in the fields

func _on_cage_id_text_changed(new_text):
	update_title_id()

func _on_subject_1_text_changed(new_text):
	get_subjects()
	update_title_id()
	
func _on_subject_2_text_changed(new_text):
	get_subjects()
	update_title_id()

func _on_subject_3_text_changed(new_text):
	get_subjects()
	update_title_id()

func _on_subject_4_text_changed(new_text):
	get_subjects()
	update_title_id()

func _on_subject_5_text_changed(new_text):
	get_subjects()
	update_title_id()




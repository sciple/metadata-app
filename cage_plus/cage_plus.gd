extends "res://node_element/node_element.gd"

var n_of_subjects = 0
var cage_id


func update_title_id():
	cage_id = get_node("cage_id").text
	#if cage_id != "Cage ID":
	self.title = "Cage ID - " + cage_id + " (n= " + str(n_of_subjects) + ")"

func get_subjects():
	var n_of_subjects = 0
	#if cage_id != "Cage ID":
	for i in range(5):
		var subject = get_node("subject_" + str(i))
		if subject.text != "":
			n_of_subjects += 1
	print(n_of_subjects)
				

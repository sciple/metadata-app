extends "res://node_element/node_element.gd"

var n_of_subjects = 0
var cage_id


func update_title_id():
	cage_id = get_node("cage_id").text
	#if cage_id != "Cage ID":
	self.title = "Cage ID: " + cage_id + " (" + str(n_of_subjects) + ")"

func get_subjects():
	n_of_subjects = 0
	#if cage_id != "Cage ID":
	for i in range(5):
		var subject = get_node("subject_" + str(i + 1))
		if subject.text != "":
			n_of_subjects += 1
	print(n_of_subjects)
				

func change_subject_color(subject_number):
	if subject_number != 0:
		var subject = get_node("subject_" + str(subject_number))
		subject.change_color()
	else:
		var cage_id = get_node("cage_id")
		cage_id.change_color()
		for i in range(1,6):
			var subject = get_node("subject_" + str(i))
			subject.change_color()

func revert_subject_color(subject_number):
	if subject_number != 0:
		var subject = get_node("subject_" + str(subject_number))
		subject.revert_color()
	else:
		var cage_id = get_node("cage_id")
		cage_id.revert_color()
		for i in range(1,6):
			var subject = get_node("subject_" + str(i))
			subject.revert_color()

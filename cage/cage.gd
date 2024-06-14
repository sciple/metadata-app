extends GraphNode

var save_path = "user://score.csv"
var string_array = PackedStringArray()

func _ready():
	#self.report()
	print(self.get_output_port_count())

	pass

func push_subjects():
	# populate the global dictionary with cageID:[sbjID]
	var cage_id = get_node("cage_id").text
	var n_of_subjects = 0
	if cage_id != "":
		Global.cages[cage_id] = []
		for i in range(5):
			var subject = get_node("subject_" + str(i) + "_id")
			if subject.text != "":
				Global.cages[cage_id].append(subject.text)
				n_of_subjects += 1
				
		self.title = "Cage ID - " + cage_id + " (n= " + str(n_of_subjects) + ")"


func report():
	print("report!!")
	var cage_id = get_node("cage_id")
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	for i in range(5):
		var subject = get_node("subject_" + str(i) + "_id")
		print(cage_id.text,'\t',subject.text)
		file.store_csv_line(PackedStringArray([cage_id.text, subject.text ]))

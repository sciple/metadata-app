extends GraphNode

var save_path = "user://score.csv"
var string_array = PackedStringArray()

# Called when the node enters the scene tree for the first time.
func _ready():
	#self.report()
	pass

func report():
	print("report!!")
	var cage_id = get_node("cage_id")
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	for i in range(5):
		var subject = get_node("subject_" + str(i) + "_id")
		print(cage_id.text,'\t',subject.text)
		file.store_csv_line(PackedStringArray([cage_id.text, subject.text ]))

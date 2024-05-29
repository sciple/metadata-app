extends GraphNode


# Called when the node enters the scene tree for the first time.
func _ready():
	#self.report()
	pass

func report():
	print("report!!")
	for i in range(5):
		var s1 = get_node("subject_" + str(i) + "_id")
		print(s1.text)

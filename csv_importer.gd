extends Node

var imported_csv = []
var imported_cages_id = {}
var header = []

func read_csv_file(path_to_file):
	var file = FileAccess.open(path_to_file, FileAccess.READ)
	
	while !file.eof_reached():
		var tmp = file.get_csv_line("\t")
		#var row = tmp[0].split('\t\"')
		var row = tmp[0].split(',')
		
		self.imported_csv.append(row)
	self.imported_csv.pop_back() #remove last empty array get_csv_line() has created
	self.get_header()	
	print("number of rows: ", len(self.imported_csv))
	print("number of columns: ", len(self.header))
	file.close()

# This is called directly by the button press
func import_csv_file(path_to_file):
	read_csv_file(path_to_file)
	self.get_set_of_cages_from_csv()
	self.get_subject_IDs()
	#print(imported_cages_id)
	self.instantiate_imported_cages()
	
func get_header():
	for i in self.imported_csv[0]:
		self.header.append(i.replace('"',""))
	
func get_column_index(column_name):
	#var index_counter = -1
	var index_counter = 0
	for i in self.header:
		if column_name == i:
			print(column_name, " | ", i, " | ", index_counter)
			return (index_counter)
		index_counter += 1

func get_set_of_cages_from_csv():
	print(self.header)
	var cage_index = get_column_index("Cage")
	#print(imported_csv[0][8])
	for row in imported_csv:
		#print(row[cage_index])
		if row[cage_index] not in self.imported_cages_id:
			self.imported_cages_id[row[cage_index].replace('"',"")] = []

func get_subject_IDs():
	var subject_index = get_column_index("ID")
	var cage_index = get_column_index("Cage")
	for row in imported_csv:
		if row[subject_index] not in self.imported_cages_id[row[cage_index].replace('"',"")]:
			self.imported_cages_id[row[cage_index].replace('"',"")].append(row[subject_index])


func instantiate_imported_cages():
	print(imported_cages_id)
	for cage in self.imported_cages_id:
		var tmp = Global.create_node("cage", cage, Global.cage_node, Global.cage_index, Vector2(50,50), "cage")
		tmp.import_cage_data(cage, imported_cages_id[cage])

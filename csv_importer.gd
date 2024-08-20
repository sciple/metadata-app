extends Node

var imported_csv = []
var imported_cages_id = []
var header

func read_csv_file(path_to_file):
	var file = FileAccess.open(path_to_file, FileAccess.READ)
	
	while !file.eof_reached():
		var tmp = file.get_csv_line("\t")
		var row = tmp[0].split('\t\"')
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
	print(imported_cages_id)
	#get_column_index("Cage")

func get_header():
	self.header = self.imported_csv[0]
	
func get_column_index(column_name):
	var index_counter = -1
	for i in self.header:
		if column_name in i:
			#print(column_name, " | ", i, " | ", index_counter)
			return (index_counter)
		index_counter += 1

func get_set_of_cages_from_csv():
	var cage_index = get_column_index("Cage")
	#print(imported_csv[0][8])
	for row in imported_csv:
		#print(row[cage_index])
		if row[cage_index] not in self.imported_cages_id:
			self.imported_cages_id.append(row[cage_index])
		

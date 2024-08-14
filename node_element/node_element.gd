extends GraphNode

var created_at
var node_type


func _ready():
	print()
	# timestamp for node creation
	created_at = Time.get_datetime_string_from_system ()
	print(self.title, " created at: ", created_at)
	
	# every inherited node must belong to a group
	node_type = self.get_groups()[0]
	print(self.node_type, " node type: ", node_type)
	
	print(self.title, " name: ", self.name)
	print("--------------------------------------")
	
	#if self.node_type == "treatment":
		#print("node to change!")
		#var new_stylebox_normal = self.get_theme_stylebox("normal").duplicate()
		#var tmp = new_stylebox_normal.get_property_list()
		#new_stylebox_normal.bg_color = Color(Global.red_color)
		#self.add_theme_stylebox_override("normal", new_stylebox_normal)



func register_node_creation():
	Global.node_elements[self.title] = {}

func register_position():
	Global.node_elements[self.title]["position"] = self.position_offset
	return self.position_offset

func register_creation_date():
	Global.node_elements[self.title]["created_at"] = self.created_at

func register_node_type():
	Global.node_elements[self.title]["type"] = self.node_type

func update_node():
	self.register_node_creation()
	self.register_creation_date()
	self.register_position()
	self.register_node_type()


# used for LOG entry addition
func _on_log_button_pressed():
	var node = load("res://log/log_entry.tscn")
	var log_entry = node.instantiate()
	$VBoxContainer.add_child(log_entry)

# used for highlighting downstream subjects (if present)
#func _on_node_selected():
	#var connected_cages = []
	#var downstream_node
	#var upstream_node
	#
	## Gather all the connected nodes
	#var connection_list = Global.main_graph.get_connection_list() # get list of all connections
	#print("List of all connections", connection_list)
	#for i in connection_list:
		#downstream_node = Global.main_graph.get_node(NodePath(i['to_node'])) # only nodes that are connected (i.e. receive a connection on the left)
		#upstream_node = Global.main_graph.get_node(NodePath(i['from_node'])) # only nodes that are connected (i.e. receive a connection on the left)
		#
		## if node is in "cage" group:
		#if downstream_node.is_in_group("cage"):# get only nodes of type: "cage"
			#if upstream_node.is_in_group("treatment"):
				#print("Connections to cages: ", i["to_port"])
				#connected_cages.append(i["to_port"])
				## activate highlight function in the cage_plus node the one_line_edit
				#downstream_node.change_subject_color(i["to_port"])
		#print(connected_cages)


#func _on_node_deselected():
	#var connected_cages = []
	#var downstream_node
	## Gather all the connected nodes
	#var connection_list = Global.main_graph.get_connection_list() # get list of all connections
	#print("List of all connections", connection_list)
	#for i in connection_list:
		#downstream_node = Global.main_graph.get_node(NodePath(i['to_node'])) # only nodes that are connected (i.e. receive a connection on the left)
		## if node is in "cage" group:
		#if downstream_node.is_in_group("cage"):# get only nodes of type: "cage"
			#print("Connections to cages: ", i["to_port"])
			#connected_cages.append(i["to_port"])
			## activate highlight function in the cage_plus node the one_line_edit
			#downstream_node.revert_subject_color(i["to_port"])
	#print(connected_cages)

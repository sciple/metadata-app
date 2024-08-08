extends Control

var node_index = 0
var connection_list

func _ready():
	OS.low_processor_usage_mode = true
	var time_it = Time.get_datetime_string_from_system ()
	print()
	print(time_it, " | MD5sum encoding: ", time_it.md5_text())

	for node in Global.main_graph.get_children():
		if node is GraphNode:
			var node_position = node.position_offset
			print (node.title, " position (x,y): ", node_position.x, " | ", node_position.y)
	print()
	

# -------------------- BUTTONS
func _on_cage_button_pressed():
	Global.create_node("cage", Global.cage_node, Global.cage_index, Vector2(50,50), "cage")
	
func _on_experiment_button_pressed():
	Global.create_node("experiment",Global.experiment_node, Global.experiment_index, Vector2(50,50), "experiment")

func _on_health_button_pressed():
	Global.create_node("health_plus",Global.health_node, Global.health_index, Vector2(50,50), "health")

func _on_comment_button_pressed():
	Global.create_node("comment_plus",Global.comment_node, Global.comment_index, Vector2(50,50), "comment")

func _on_treatment_button_pressed():
	Global.create_node("treatment",Global.treatment_node, Global.treatment_index, Vector2(50,50), "treatment")

func _on_operator_button_pressed():
	Global.create_node("operator",Global.operator_node, Global.operator_index, Vector2(50,50), "operator")

func _on_genotype_button_pressed():
	Global.create_node("genotype",Global.genotype_node, Global.genotype_index, Vector2(50,50), "genotype")


# -------------------- GLOBAL FUNCTIONS
func _on_graph_edit_connection_request(from_node, from_port, to_node, to_port):
	$GraphEdit.connect_node(from_node, from_port, to_node, to_port)

func _on_graph_edit_disconnection_request(from_node, from_port, to_node, to_port):
	$GraphEdit.disconnect_node(from_node, from_port, to_node, to_port)


func save_data():
	# empty directory before saving to avoid duplicates
	var dir = DirAccess.open("res://saved_data/")
	var nodes_to_erase = dir.get_files()
	for node_to_erase in nodes_to_erase:
		dir.remove("res://saved_data/" + node_to_erase)
	
	save_connections()
	
	var packed_scene = PackedScene.new()
	var nodes_to_save = Global.main_graph.get_children()
	for node_to_save in nodes_to_save:
		packed_scene.pack(node_to_save)
		if ResourceSaver.save(packed_scene, "res://saved_data/" + node_to_save.name + ".tscn") == OK:
			print("saved: ", node_to_save.name)
		else:
			print("Error saving graph_data")

	#for sub_node in node_to_save.get_children():
		#sub_node.owner = node_to_save

func save_connections():
	var connections = Global.main_graph.get_connection_list()
	var save_file = FileAccess.open("res://saved_data/connections/connections.save", FileAccess.WRITE)
	var json_string = JSON.stringify(connections)
	save_file.store_line(json_string)
	print(json_string)
	
#func init_graph(graph_data: GraphData):
	#clear_graph()
	#for node in graph_data.nodes:
		## Get new node from factory autoload (singleton)
		#var gnode = PartFactory.get_node(node.type)
		#gnode.offset = node.offset
		#gnode.name = node.name
		#get_node("Graph").add_child(gnode)
	#for con in graph_data.connections:
		#var _e = get_node("Graph").connect_node(con.from, con.from_port, con.to, con.to_port)


func load_data():
	print("--------------- LOAD function --------------- ")
	var dir = DirAccess.open("res://saved_data/")
	if dir:
		clear_graph()
		var nodes_to_load = dir.get_files()
		for node_to_load in nodes_to_load:
			var path_to_node = "res://saved_data/" + node_to_load
			var packed_scene = load(path_to_node)
			var my_scene = packed_scene.instantiate()
			Global.main_graph.add_child(my_scene)
		restore_connections()
		
		
func restore_connections():
	var save_file = FileAccess.open("res://saved_data/connections/connections.save", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		
		# Creates the helper class to interact with JSON
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object
		var connection_data = json.get_data()
		for con in connection_data:
			print(con)
			var _e = Global.main_graph.connect_node(con.from_node, con.from_port, con.to_node, con.to_port)
	
	
	
	
func clear_graph():
	Global.main_graph.clear_connections()
	var nodes = Global.main_graph.get_children()
	for node in nodes:
		if node is GraphNode:
			node.queue_free()
			node.free()


#func save():
	#Global.init_subjects()
	#Global.init_node_elements()
	#get_cages() # collects all cages to be pushed to the global store
	#print(Global.node_elements)
	#update_global_stats()
	#print()
	
	#var connection_list = G.get_connection_list()
	#print(connection_list)
	#for i in range(0, connection_list.size()):
		## node obtained form the connection list
		#var from = G.get_node(NodePath(connection_list[i]['from_node']))
		#var to = G.get_node(NodePath(connection_list[i]['to_node']))
		#print(from.name, ' >>> ', to.name)
		
		#if to.has_method("report"):
			# the FROM node shouldbe passed to report
			# then the report should generate an extra column
			# in the report with the name of the FROM node
			#to.report()
	

func get_cages():
	# loop over all cages
	# this function should be applied independently for all different groups of nodes
	print('execute: get_cages()')
	connection_list = Global.main_graph.get_connection_list() # get list of all connections
	for i in connection_list:
		var cage = Global.main_graph.get_node(NodePath(i['to_node'])) # only nodes that are connected (i.e. receive a connection on the left)
		if cage.is_in_group("cage"):# get only nodes of type: "cage"
			cage.get_subjects()
			cage.update_title_id()
			cage.update_node()
	
	
func update_global_stats():
	for cage in Global.cages:
		Global.total_number_of_subjects += Global.cages[cage].size()
	$subject_count.text = str(Global.total_number_of_subjects)
	$cage_count.text = ", " + str(Global.cages.size())

func _on_save_button_pressed():
	save_data()

func _on_load_button_pressed():
	load_data()

func _input(event):
	if event is InputEventMouseButton and event.is_released() and event.button_index == MOUSE_BUTTON_RIGHT:
		print("Mouse Click/Unclick at: ", event.position)
		print(Global.main_graph.zoom)
		print(event.position)
		print(event.position / Global.main_graph.zoom)
		#tmp.position = (G.scroll_offset + G.size / 2) / G.zoom - node.size / 2;
		var tmp_position = (Global.main_graph.scroll_offset + Global.main_graph.size / 2) / Global.main_graph.zoom
		Global.create_node("cage", Global.cage_node, Global.cage_index, tmp_position)
		#Global.create_node("cage", Global.cage_node, Global.cage_index, event.position * G.zoom)

var selected_nodes = {}

func _on_graph_edit_node_selected(node):
	selected_nodes[node] = true

func _on_graph_edit_node_deselected(node):
	selected_nodes[node] = false

func _on_graph_edit_delete_nodes_request(nodes):
	get_node("GraphEdit/ConfirmationDialog").visible=true

func _on_confirmation_dialog_confirmed():
	for node in selected_nodes.keys():
		if selected_nodes[node]:
			node.queue_free()
	selected_nodes = {}

func _on_confirmation_dialog_canceled():
	selected_nodes = {}

extends Control

#var cage_node = load("res://cage/cage.tscn")
#var experiment_node = load("res://experiment/experiment.tscn")
#var parent_node = load("res://cage/parent_cage.tscn")
#var health_node = load("res://health/health.tscn")
#var comment_node = load("res://comment/comment.tscn")
#var treatment_node = load("res://treatment/treatment.tscn")

# object that holds the graphedit object
var G

var initial_position = Vector2(40,40)
var node_index = 0
var connection_list

func _ready():
	OS.low_processor_usage_mode = true
	var time_it = Time.get_datetime_string_from_system ()
	print(time_it, " | MD5sum encoding: ", time_it.md5_text())
	print()
	G = $GraphEdit

	for node in G.get_children():
		if node is GraphNode:
			var node_position = node.position_offset
			print (node.title, " position (x,y): ", node_position.x, " | ", node_position.y)
	print()


# -------------------- BUTTONS
func _on_cage_button_pressed():
	Global.create_node("cage", Global.cage_node, Global.cage_index)

func _on_experiment_button_pressed():
	Global.create_node("experiment",Global.experiment_node, Global.experiment_index)

func _on_health_button_pressed():
	Global.create_node("health_plus",Global.health_node, Global.health_index)

func _on_comment_button_pressed():
	Global.create_node("comment",Global.comment_node, Global.comment_index)

func _on_treatment_button_pressed():
	Global.create_node("treatment",Global.treatment_node, Global.treatment_index)

func _on_operator_button_pressed():
	Global.create_node("operator",Global.operator_node, Global.operator_index)


# -------------------- GLOBAL FUNCTIONS
func _on_graph_edit_connection_request(from_node, from_port, to_node, to_port):
	$GraphEdit.connect_node(from_node, from_port, to_node, to_port)

func _on_graph_edit_disconnection_request(from_node, from_port, to_node, to_port):
	$GraphEdit.disconnect_node(from_node, from_port, to_node, to_port)


func save():
	#Global.init_subjects()
	Global.init_node_elements()
	get_cages() # collects all cages to be pushed to the global store
	print(Global.node_elements)
	#update_global_stats()
	print()
	
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
	connection_list = G.get_connection_list() # get list of all connections
	for i in connection_list:
		var cage = G.get_node(NodePath(i['to_node'])) # only nodes that are connected (i.e. receive a connection on the left)
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
	save()




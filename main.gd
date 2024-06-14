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
	print(time_it)
	print(time_it.md5_text())
	G = $GraphEdit


# -------------------- BUTTONS
func _on_cage_button_pressed():
	Global.create_node("cage", Global.cage_node, Global.cage_index)

func _on_experiment_button_pressed():
	Global.create_node("experiment",Global.experiment_node, Global.experiment_index)

func _on_parent_button_pressed():
	Global.create_node("parent",Global.parent_node, Global.parent_index)

func _on_health_button_pressed():
	Global.create_node("health",Global.health_node, Global.health_index)

func _on_comment_button_pressed():
	Global.create_node("comment",Global.comment_node, Global.comment_index)

func _on_treatment_button_pressed():
	Global.create_node("treatment",Global.treatment_node, Global.treatment_index)


# -------------------- GLOBAL FUNCTIONS
func _on_graph_edit_connection_request(from_node, from_port, to_node, to_port):
	$GraphEdit.connect_node(from_node, from_port, to_node, to_port)

func _on_graph_edit_disconnection_request(from_node, from_port, to_node, to_port):
	$GraphEdit.disconnect_node(from_node, from_port, to_node, to_port)


func save():
	Global.init_subjects()
	get_cages()
	print(Global.total_number_of_subjects)
	print(Global.cages)
	update_global_stats()
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
	print('execute: get_cages()')
	connection_list = G.get_connection_list()
	for i in connection_list:
		var n = G.get_node(NodePath(i['to_node']))
		if n.is_in_group("cage"):
			n.push_subjects()
	print(Global.cages)
	
	
func update_global_stats():
	for cage in Global.cages:
		Global.total_number_of_subjects += Global.cages[cage].size()
	$subject_count.text = str(Global.total_number_of_subjects)
	$cage_count.text = ", " + str(Global.cages.size())

func _on_save_button_pressed():
	save()

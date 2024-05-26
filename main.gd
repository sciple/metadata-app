extends Control

var cage_node = load("res://cage/cage.tscn")
var experiment_node = load("res://experiment/experiment.tscn")
var parent_node = load("res://cage/parent_cage.tscn")
var health_node = load("res://health/health.tscn")
var comment_node = load("res://comment/comment.tscn")
var treatment_node = load("res://treatment/treatment.tscn")


var initial_position = Vector2(40,40)
var node_index = 0

func _ready():
	var time_it = Time.get_datetime_string_from_system ()
	print(time_it)
	print(time_it.md5_text())


func _on_cage_button_pressed():
	var node = cage_node.instantiate()
	$GraphEdit.add_child(node)
	node_index += 1

func _on_experiment_button_pressed():
	var node = experiment_node.instantiate()
	$GraphEdit.add_child(node)
	node_index += 1


func _on_parent_button_pressed():
	var node = parent_node.instantiate()
	$GraphEdit.add_child(node)
	node_index += 1

func _on_health_button_pressed():
	var node = health_node.instantiate()
	$GraphEdit.add_child(node)
	node_index += 1

func _on_comment_button_pressed():
	var node = comment_node.instantiate()
	$GraphEdit.add_child(node)
	node_index += 1

func _on_treatment_button_pressed():
	var node = treatment_node.instantiate()
	$GraphEdit.add_child(node)
	node_index += 1


func _on_graph_edit_connection_request(from_node, from_port, to_node, to_port):
	$GraphEdit.connect_node(from_node, from_port, to_node, to_port)

func _on_graph_edit_disconnection_request(from_node, from_port, to_node, to_port):
	$GraphEdit.disconnect_node(from_node, from_port, to_node, to_port)


func save():
	var G = $GraphEdit
	var connection_list = G.get_connection_list()
	print(connection_list)
	#for i in range(0, connection_list.size()):
		#var result = G.get_node(NodePath(connection_list[i]['from_node']))
		##G.get
		#print(result.get_node("vendor").text)


func _on_save_button_pressed():
	save()

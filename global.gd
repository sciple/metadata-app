extends Node

var global_index = -1
var cage_index = -1
var experiment_index = -1
var parent_index = -1
var health_index = -1
var comment_index = -1
var treatment_index = -1

var total_number_of_subjects = 0
var cages = {}

var cage_node = load("res://cage/cage.tscn")
var experiment_node = load("res://experiment/experiment.tscn")
var parent_node = load("res://cage/parent_cage.tscn")
var health_node = load("res://health/health.tscn")
var comment_node = load("res://comment/comment.tscn")
var treatment_node = load("res://treatment/treatment.tscn")


func create_node(node_name, node_type, node_index):
	var node = node_type.instantiate()
	node_index += 1
	get_node("../Main/GraphEdit").add_child(node)
	node.name = node_name + "_" + str(node_index)

	

func init_subjects():
	self.cages = {}
	self.total_number_of_subjects = 0


		


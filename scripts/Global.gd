extends Node

signal score_updated(new_score)

var player_score: int = 0

func add_score(amount):
	self.player_score += amount
	score_updated.emit(player_score)

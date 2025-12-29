extends AudioStreamPlayer

#Using this as a hack to make the music play in a loop.
#I tried a lot of solutions but none of them work
func _on_finished() -> void:
	play()

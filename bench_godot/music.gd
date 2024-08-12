extends AudioStreamPlayer


func _on_audio_toggle_button_pressed():
	stream_paused = !stream_paused


func _on_finished():
	play() # Replace with function body.

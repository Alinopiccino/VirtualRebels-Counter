extends Node

signal connected
signal failed

func host():
	var peer = ENetMultiplayerPeer.new()
	var result = peer.create_server(9999)
	print("HOST RESULT:%d" % result)
	if result == OK:
		multiplayer.multiplayer_peer = peer
		connected.emit()
	else:
		failed.emit()

func join():
	var peer = ENetMultiplayerPeer.new()
	var result = peer.create_client("127.0.0.1", 9999) # <--- Cambia IP se necessario
	print("JOIN RESULT:%d" % result)
	if result == OK:
		multiplayer.multiplayer_peer = peer
		connected.emit()
	else:
		failed.emit()

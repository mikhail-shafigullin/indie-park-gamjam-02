extends Usable

enum LOC {MAIN_HALL, MC_ROOM, MOM_ROOM, BATHROOM}

@export var location: LOC;

func useObject():
	print("location is:", location)
	match location:
		LOC.MAIN_HALL:
			Dialogic.start("MainHallMirror")
		LOC.MC_ROOM:
			Dialogic.start("MCRoomMirror")
		LOC.MOM_ROOM:
			Dialogic.start("BedroomMirror")
		LOC.BATHROOM:
			Dialogic.start("BathroomMirror")

extends Usable

func useObject():
	if(PuzzleStates.puzzle4Solved):
		Dialogic.start("MainHallEntranceDoor", "doorOutro")
	else:
		Dialogic.start("MainHallEntranceDoor", "doorUseWithoutItems")

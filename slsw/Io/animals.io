Object ancestors := method(
	prototype := self proto
	if(prototype != Object,
	writeLn("Slot of ", prototype type, "\n-----------")
	prototype slotNames foreach(slotName, writeLn(slotName))
	writeLn
	prototype ancestors))

Animal := Object clone
Animal speak := method ("ambiguous animal noise" printLn)

Duck := Animal clone
Duck speak := method(
	"quack" printLn
)
Duck walk := method("waddle" printLn)

disco := Duck clone

disco ancestors
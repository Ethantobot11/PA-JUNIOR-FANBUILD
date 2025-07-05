local luaNote = "Glitch Miss Note"
function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == luaNote then
			--setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_assets'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0.023'); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0.0475'); --Default value is: 0.0475, health lost on miss
			--setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', true);
			setPropertyFromGroup('unspawnNotes', i, 'oppMissNote', true);
			--setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
		end
	end
	--debugPrint('Script started!')
end

-- Function called when you hit a note (after note hit calculations)
-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
-- noteType: The note type string/tag
-- isSustainNote: If it's a hold note, can be either true or false
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == luaNote then
		--[[cameraShake("game", 0.1, 0.2)
		playAnim("boyfriend", "dodge", true)
		setProperty("boyfriend.specialAnim", true)
		playSound("glitchhit", 0.3)--]]
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == luaNote then

	end
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == luaNote then

	end
end
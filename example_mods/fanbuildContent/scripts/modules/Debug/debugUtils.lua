local slowDownKeybind = "F1";
local baseSpeedKeybind = "F2";
local speedUpKeybind = "F3";
local botplayKeybind = "F12";
local rewind10Seconds = "F9";
local skip10Seconds = "F10";

function onUpdate(elapsed)
	if debugBuild then
		if keyboardPressed(slowDownKeybind) or keyboardPressed(speedUpKeybind) then
			holdSpeed = holdSpeed + (elapsed * 0.01);
		else
			holdSpeed = 0;
		end

		if keyboardJustPressed(rewind10Seconds) then
			runHaxeCode([[
				game.setSongTime(Conductor.songPosition - 10000);
				game.clearNotesBefore(Conductor.songPosition);
			]])
		end
		if keyboardJustPressed(skip10Seconds) then
			local prevCurStep = curStep;
			runHaxeCode([[
				game.setSongTime(Conductor.songPosition + 10000);
				game.clearNotesBefore(Conductor.songPosition);
			]])
			for i = prevCurStep, curStep do
				runHaxeCode([[game.setOnLuas('curStep', ]]..i..[[);]])
				callOnLuas("onStepHit", {}, false, true)
			end
		end
	
		if keyboardJustPressed(botplayKeybind) then setProperty("cpuControlled", not getProperty("cpuControlled")) end

		if keyboardJustPressed(slowDownKeybind) then setProperty("playbackRate", playbackRate - 0.1) end
		if keyboardPressed(slowDownKeybind) then setProperty("playbackRate", playbackRate - holdSpeed) end
		if playbackRate < 0.01 then setProperty("playbackRate", 0.01) end
		if keyboardJustPressed(speedUpKeybind) then setProperty("playbackRate", playbackRate + 0.1) end
		if keyboardPressed(speedUpKeybind) then setProperty("playbackRate", playbackRate + holdSpeed) end
		if playbackRate > 5 then setProperty("playbackRate", 5) end
		if keyboardJustPressed(baseSpeedKeybind) then setProperty("playbackRate", 1) end
	end
end

function goodNoteHit(index, noteDir, noteType, isSustainNote)
	if getProperty("cpuControlled") and debugBuild and not isSustainNote then
		runHaxeCode([[
			var note = game.notes.members[ ]]..index..[[ ];
			var noteDiff:Float = Math.abs(note.strumTime - Conductor.songPosition + ClientPrefs.data.ratingOffset);

			//tryna do MS based judgment due to popular demand
			var daRating:Rating = Conductor.judgeNote(game.ratingsData, noteDiff / game.playbackRate);

			game.totalNotesHit += daRating.ratingMod;
			note.ratingMod = daRating.ratingMod;
			if(!note.ratingDisabled) daRating.hits++;
			note.rating = daRating.name;
			var score = daRating.score;

			game.songScore += score;
			if(!note.ratingDisabled)
			{
				game.songHits++;
				game.totalPlayed++;
				game.RecalculateRating(false);
			}
		]])
	end
end
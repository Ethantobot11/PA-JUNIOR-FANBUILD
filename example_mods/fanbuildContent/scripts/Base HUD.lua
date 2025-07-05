local songNoSpecialLetters = string.lower(string.gsub(string.gsub(songName, "'", ""), " ", "-"))

function onCreate()
	--vars xd
	setVar("dadCamZoom", -1)
	setVar("videos", true) --should probably make this into an option huh

	initSaveData("Junior's Pibby Apocalypse Fanbuild")
	setWindowTitle(songName.." - Composed by "..string.gsub(getSongArtist(songName), "\n", " "))
end

function onCreatePost()
	if getProperty("gf") ~= nil then
		runHaxeCode([[
			var iconPibby = new HealthIcon(game.gf.healthIcon, true);
			iconPibby.y = game.healthBar.y - 77;
			iconPibby.visible = game.iconP1.visible;
			iconPibby.alpha = game.iconP1.alpha;
			iconPibby.camera = game.camHUD;
			game.add(iconPibby);
			game.modchartSprites.set("iconPibby", iconPibby);
		]])
	end
	setObjectOrder("dadGroup", getObjectOrder("boyfriendGroup")+1)

	makeLuaText("lyricTxt", "", screenWidth, 0, 120)
	setTextAlignment("lyricTxt", "center")
	setTextBorder("lyricTxt", 0, "000000")
	setScrollFactor("lyricTxt")
	setProperty("lyricTxt.alpha", 0)
	if downscroll then setProperty("lyricTxt.y", screenHeight - 240) end
	addLuaText("lyricTxt")
	setObjectCamera("lyricTxt", "other")
	setTextSize("lyricTxt", 44)
	setTextFont("lyricTxt", "yu-gothic.ttf")
	runHaxeCode([[game.getLuaObject("lyricTxt").color = FlxColor.WHITE;]])

	if songName == "Fallen Hero" or songName == "Woah" then
		makeLuaText("warningTxt", "GAMEPLAY NOT FINAL", screenWidth, 0, 40)
		setTextAlignment("warningTxt", "center")
		setTextFont("warningTxt", "menuTHEME.ttf")
		setTextSize("warningTxt", 38)
		setTextBorder("warningTxt", 0, "000000")
		setScrollFactor("warningTxt")
		setProperty("warningTxt.alpha", 0.5)
		if downscroll then setProperty("warningTxt.y", screenHeight - 80) end
		addLuaText("warningTxt")
		setObjectCamera("warningTxt", "other")
		setTextSize("warningTxt", 38)
	end

	makeLuaSprite('cinematicup', '', -10, -360)
	makeGraphic("cinematicup", screenWidth+20, 360, "000000")
	setScrollFactor("cinematicup", 0, 0)
	setObjectCamera("cinematicup", "hud")
	addLuaSprite('cinematicup', false)
	makeLuaSprite('cinematicdown', '', 0-10, screenHeight)
	makeGraphic("cinematicdown", screenWidth+20, 360, "000000")
	setScrollFactor("cinematicdown", 0, 0)
	setObjectCamera("cinematicdown", "hud")
	addLuaSprite('cinematicdown', false)

	makeLuaSprite("blackie", "", -screenWidth, -screenHeight)
	makeGraphic("blackie", screenWidth * 3, screenHeight * 3, "000000")
	setScrollFactor("blackie")
	setProperty("blackie.alpha", 0)
	addLuaSprite("blackie",true)
	makeLuaSprite("whitey", "", -screenWidth, -screenHeight)
	makeGraphic("whitey", screenWidth * 3, screenHeight * 3, "FFFFFF")
	setScrollFactor("whitey")
	setProperty("whitey.alpha", 0)
	addLuaSprite("whitey",true)

	makeLuaSprite("cnlogo", "", 0, 0)
	setProperty("cnlogo.alpha", 0.5)
	setObjectCamera("cnlogo", "other")
	runHaxeCode([[
		var time = Date.now().getHours();
		trace("Current hour: " + time);
		var cnlogo = game.getLuaObject("cnlogo", false);
		if ((time >= 17 && time <= 24) || (time >= 1 && time <= 6)) {
			cnlogo.loadGraphic(Paths.image('aslogo'));
			cnlogo.x = 1046.5;
			cnlogo.y = 660;
			cnlogo.setGraphicSize(Std.int(cnlogo.width * 0.09));
			cnlogo.updateHitbox();
			//trace(cnlogo.y);
		} else {
			cnlogo.loadGraphic(Paths.image('cnlogo'));
			cnlogo.x = 990;
			cnlogo.y = 600;
			cnlogo.setGraphicSize(Std.int(cnlogo.width * 0.17));
			cnlogo.updateHitbox();
			//trace(cnlogo.y);	
		}
	]])
	if downscroll then setProperty("cnlogo.y", getProperty("cnlogo.y") - 530) end
	addLuaSprite("cnlogo", true)

	makeLuaSprite("theBlackness", "", -screenWidth * getProperty("camGame.zoom"), -screenHeight * getProperty("camGame.zoom"))
	makeGraphic("theBlackness", screenWidth * 3, screenHeight * 3, "000000")
	setScrollFactor("theBlackness")
	setProperty("theBlackness.alpha", 0)
	addLuaSprite("theBlackness")
	setObjectOrder("theBlackness", getObjectOrder("gfGroup") -1)

	makeLuaSprite("theWhiteness", "", -screenWidth * getProperty("camGame.zoom"), -screenHeight * getProperty("camGame.zoom"))
	makeGraphic("theWhiteness", screenWidth * 3, screenHeight * 3, "FFFFFF")
	setScrollFactor("theWhiteness")
	setProperty("theWhiteness.alpha", 0)
	addLuaSprite("theWhiteness")
	setObjectOrder("theWhiteness", getObjectOrder("gfGroup") -1)

	for i = 0, getProperty("unspawnNotes.length") do
		if getPropertyFromGroup("unspawnNotes", i, "noteType") == "GF Sing" and not getPropertyFromGroup("unspawnNotes", i, "mustPress") then
			setPropertyFromGroup("unspawnNotes", i, "visible", false)
		end
	end
end

function cameraBump(isFinal)
	if isFinal == nil then isFinal = false; end
	if cameraZoomOnBeat then setProperty("camGame.zoom", getProperty("camGame.zoom") + 0.1) end
	if cameraZoomOnBeat then setProperty("camHUD.zoom", getProperty("camHUD.zoom") + 0.1) end

	-- why this vars exist they don't do anything special :sobs:
	if isFinal then
		doTweenZoom("cameraBumpTween", "camGame", getProperty("defaultCamZoom"), 0.4 / playbackRate, "quartOut")
		doTweenZoom("cameraHUDBumpTween", "camHUD", 1, 0.4 / playbackRate, "quartOut")
	else
		doTweenZoom("cameraBumpTween", "camGame", getProperty("camGame.zoom") - 0.05, 0.4 / playbackRate, "quartOut")
		doTweenZoom("cameraHUDBumpTween", "camHUD", getProperty("camHUD.zoom") - 0.05, 0.4 / playbackRate, "quartOut")
	end

	if isFinal then
		setProperty("camHUD.alpha", 1)
		if songName == 'Suffering Siblings' or songName == 'No Hero Remix' or songName == 'Come Along With Me' or getProperty("storyWeekName") == 'gumball' then setProperty("camHUD.alpha", 0) end
		if flashingLights then cameraFlash("other", "FFFFFF", 0.25 / playbackRate) end
	end
end

function startSongCredits(timer)
	makeLuaText("songTitle", getSongName(songName), screenWidth, 0, 0)
	setTextSize("songTitle", 92)
	screenCenter("songTitle")
	setProperty("songTitle.y", getProperty("songTitle.y") - 10)

	makeLuaSprite("creditsBar", "creditBar", 0, 0)
	setObjectCamera("creditsBar", "other")
	addLuaSprite("creditsBar", true)
	setProperty("creditsBar.alpha", 0)

	makeLuaText("songInfo", getSongInfo(songName), screenWidth, 0, 0)
	setTextSize("songInfo", 48)
	setProperty("songInfo.y", getProperty("songTitle.y") + 95)
	if getProperty("storyWeekName") ~= "gumball" then setProperty("songInfo.y", getProperty("songInfo.y") + 10) end

	makeLuaText("songCredits", "By "..getSongArtist(songName), screenWidth, 0, 0)
	setTextSize("songCredits", 48)
	setProperty("songCredits.y", getProperty("songInfo.y") + 35)
	if getProperty("storyWeekName") ~= "gumball" then setProperty("songCredits.y", getProperty("songInfo.y") + 45) end

	local stupidFucks = {"songTitle", "songInfo", "songCredits"}
	for i = 1, #stupidFucks do
		setTextAlignment(stupidFucks[i], "center")
		setTextFont(stupidFucks[i], getProperty("storyWeekName")..".ttf")
		setTextBorder(stupidFucks[i], 1, "000000")
		addLuaText(stupidFucks[i])
		setObjectCamera(stupidFucks[i], "other")
		if getProperty("storyWeekName") ~= "gumball" then
			setTextSize(stupidFucks[i], getTextSize(stupidFucks[i]) - 15)
		end

		setProperty(stupidFucks[i]..".alpha", 0)
	end

	doTweenAlpha("songTitle", "songTitle", 1, (timer / 4) / playbackRate)
	doTweenAlpha("creditsBar", "creditsBar", 1, (timer / 4) / playbackRate)
	
	doTweenAlphaDelay("songInfoShart", "songInfo", 1, 1 / playbackRate, "", (timer / 3) / playbackRate)
	doTweenAlphaDelay("songCreditsShart", "songCredits", 1, 1 / playbackRate, "", (timer / 3) / playbackRate)

	doTweenAlphaDelay("songTitleShart", "songTitle", 0, 1 / playbackRate, "", timer / playbackRate)
	doTweenAlphaDelay("creditsBarShart", "creditsBar", 0, 1 / playbackRate, "", timer / playbackRate)
	doTweenAlphaDelay("songInfoShart2", "songInfo", 0, 1 / playbackRate, "", timer / playbackRate)
	doTweenAlphaDelay("songCreditsShart2", "songCredits", 0, 1 / playbackRate, "", timer / playbackRate)
end

function onCountdownTick(swagCounter)
	if swagCounter == 0 then
		makeAnimatedLuaSprite("numberIntro", "Numbers", 0, 0)
		setObjectCamera("numberIntro", "other")
		updateHitbox("numberIntro")
		screenCenter("numberIntro")
		setProperty("numberIntro.x", getProperty("numberIntro.x") - 100)
		setProperty("numberIntro.y", getProperty("numberIntro.y") - 25)
		addAnimationByPrefix("numberIntro", "3", "3", 30, false)
		addAnimationByPrefix("numberIntro", "2", "2", 30, false)
		addAnimationByPrefix("numberIntro", "1", "1", 30, false)
		addAnimationByPrefix("numberIntro", "go", "Go", 30, false)
		setProperty("numberIntro.alpha", 0.001)
		runHaxeCode([[game.getLuaObject("numberIntro").animation.finishCallback = (name) -> {game.getLuaObject("numberIntro").visible = false;}]])
		addLuaSprite("numberIntro", false)
		for i = 0, 7 do
			if downscroll then 
				setPropertyFromGroup("strumLineNotes", i, 'y', getPropertyFromGroup("strumLineNotes", i, "y") + 160) 
			else 
				setPropertyFromGroup("strumLineNotes", i, 'y', getPropertyFromGroup("strumLineNotes", i, "y") - 160) 
			end
		end
		
		cameraBump();
		setProperty("numberIntro.alpha", 1)
		
		playAnim("numberIntro", "3")
	end
	if swagCounter == 1 then
		cameraBump();
		
		setProperty("numberIntro.visible", true)
		playAnim("numberIntro", "2")
		setProperty("numberIntro.offset.x", -85)
		setProperty("numberIntro.offset.y", -58)
	end
	if swagCounter == 2 then
		cameraBump();
		
		setProperty("numberIntro.visible", true)
		playAnim("numberIntro", "1")
		setProperty("numberIntro.offset.x", -72)
		setProperty("numberIntro.offset.y", -47)
	end
	if swagCounter == 3 then
		cameraBump(true);

		setProperty("numberIntro.visible", true)
		playAnim("numberIntro", "go")
		setProperty("numberIntro.offset.x", 98)
		setProperty("numberIntro.offset.y", 15)
	end
	if swagCounter == 4 then
		setProperty("numberIntro.alpha", 0)
		removeLuaSprite("numberIntro", true)
	end
end

function onSongStart()
	if getProperty("skipCountdown") then
		for i = 0, 7 do
			if downscroll then 
				setPropertyFromGroup("strumLineNotes", i, 'y', getPropertyFromGroup("strumLineNotes", i, "y") + 160) 
			else 
				setPropertyFromGroup("strumLineNotes", i, 'y', getPropertyFromGroup("strumLineNotes", i, "y") - 160) 
			end
		end
	end

	local delayBF = -1;
	local delayDAD = -1;
	for i = 0, getProperty("unspawnNotes.length") do
		if getPropertyFromGroup("unspawnNotes", i, "mustPress") and delayBF == -1 then
			delayBF = (getPropertyFromGroup("unspawnNotes", i, "strumTime") / 1000) - 1.5;
		elseif not getPropertyFromGroup("unspawnNotes", i, "mustPress") and delayDAD == -1 then
			delayDAD = (getPropertyFromGroup("unspawnNotes", i, "strumTime") / 1000) - 1.5;
		end
		if delayBF ~= -1 and delayDAD ~= -1 then break; end
	end
	for i = 0, 3 do
		if downscroll then
			doTweenYDelay("playerStrumNote"..i, "playerStrums.members["..i.."]", getPropertyFromGroup("playerStrums", i, "y") - 160, 1.5, "sineOut", delayBF / playbackRate)
			doTweenYDelay("opponentStrumNote"..i, "opponentStrums.members["..i.."]", getPropertyFromGroup("opponentStrums", i, "y") - 160, 1.5, "sineOut", delayDAD / playbackRate)
		else
			doTweenYDelay("playerStrumNote"..i, "playerStrums.members["..i.."]", getPropertyFromGroup("playerStrums", i, "y") + 160, 1.5, "sineOut", delayBF / playbackRate)
			doTweenYDelay("opponentStrumNote"..i, "opponentStrums.members["..i.."]", getPropertyFromGroup("opponentStrums", i, "y") + 160, 1.5, "sineOut", delayDAD / playbackRate)
		end
	end

	local foundCreditFunc = false;
	if checkFileExists("data/"..songNoSpecialLetters.."/script.lua") then  if string.find(getTextFromFile("data/"..songNoSpecialLetters.."/script.lua"), "startSongCredits") then foundCreditFunc = true; end  end
	if checkFileExists("data/"..songNoSpecialLetters.."/script.hx") then  if string.find(getTextFromFile("data/"..songNoSpecialLetters.."/script.hx"), "startSongCredits") then foundCreditFunc = true; end  end
	if not foundCreditFunc then startSongCredits(stepCrochet / 20) end
end

function updateColors(dad, gf) --don't wanna have this code several times in the script.
	if not dad and gf and getProperty("gf") ~= nil then
		runHaxeCode([[
			var charColor = FlxColor.fromRGB(game.gf.healthColorArray[0],game.gf.healthColorArray[1],game.gf.healthColorArray[2]);
			game.scoreTxt.color = charColor;
		]])
		return;
	end 
	runHaxeCode([[
		var charColor = FlxColor.fromRGB(game.boyfriend.healthColorArray[0],game.boyfriend.healthColorArray[1],game.boyfriend.healthColorArray[2]);
		game.scoreTxt.color = charColor;
	]])
end

function onEvent(eventName, value1, value2)
	if eventName == "Change Character" then
		if value1 == "dad" then updateColors(true, false) end
		if value1 == "bf" then updateColors(false, false) end
	end
end

function goodNoteHit(index, noteDir, noteType, isSustainNote)
	if noteType == "GF Sing" or gfSection and not isSustainNote then
		updateColors(false, true)
		if string.match(boyfriendName, "Darwin") then
			setProperty("gf.specialAnim", true)
		end
	else
		if not isSustainNote then updateColors(false, false) end
		if string.match(boyfriendName, "newbf") or string.match(boyfriendName, "Darwin") then
			setProperty("boyfriend.specialAnim", true)
		end
	end
end
function opponentNoteHit(index, noteDir, noteType, isSustainNote)
	if dadName == "cumball" then
		setProperty("dad.specialAnim", true)
	end
end

local angleshit = 1.0;
function onBeatHit()
	if killyourself and getProperty("camZooming") then --FOR THE FUNNY
		if curBeat % 2 == 0 then
			angleshit = angleshit * -1;
		else
			angleshit = angleshit * -1;
		end
		setProperty("camHUD.angle", angleshit * 3)
		setProperty("camGame.angle", angleshit * 3)
		doTweenAngle("camHUDAngleTWEEN", "camHUD", angleshit, (stepCrochet * 0.002) / playbackRate, "circOut")
		doTweenAngle("camGameAngleTWEEN", "camGame", angleshit, (stepCrochet * 0.002) / playbackRate, "circOut")
		doTweenX("camHUDXTween", "camHUD", -angleshit*8, (crochet * 0.001) / playbackRate)
		doTweenX("camGameXTween", "camGame", -angleshit*8, (crochet * 0.001) / playbackRate)
	end
end

function onDestroy()
	flushSaveData("Junior's Pibby Apocalypse Fanbuild")
end
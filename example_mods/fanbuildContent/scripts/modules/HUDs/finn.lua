local dodgeMisses = 0;

function onCreate()
	if getProperty("pauseMenuChar") == nil then setProperty("pauseMenuChar", "finn-revealed") end
	if songName == "Suffering Siblings" then
		runHaxeCode([[
			var jake = new Character(250, 10, "jake");
			game.startCharacterPos(jake, true);
		    game.dadGroup.add(jake);
			game.modchartSprites.set("jake", jake);
		]])

	end
end
function onCreatePost()
	setProperty("healthBar.visible", false)
	setProperty("healthBar.alpha", 0)

	makeAnimatedLuaSprite("finnBarThing", "healthbar/iconbar", 197, 565)
	addAnimationByPrefix("finnBarThing", "idle2", "Icons Bar 2", 24, true)
	addAnimationByPrefix("finnBarThing", "idle3", "Icons Bar 1", 24, true)
	addAnimationByPrefix("finnBarThing", "idle1", "Icons Bar 3", 24, true)
	setObjectCamera("finnBarThing", "hud")
	addLuaSprite("finnBarThing")
	if downscroll then setProperty("finnBarThing.y", 0.2) end
	playAnim("finnBarThing", "medium")
	setObjectOrder("finnBarThing", getObjectOrder("uiGroup") - 1)

	if songName == "Suffering Siblings" then
		runHaxeCode([[
			var iconJake = new HealthIcon(game.getLuaObject("jake").healthIcon, false);
			iconJake.y = game.healthBar.y - 77;
			iconJake.visible = game.iconP2.visible;
			iconJake.alpha = game.iconP2.alpha;
			iconJake.camera = game.camHUD;
			game.add(iconJake);
			game.modchartSprites.set("iconJake", iconJake);
		]])
		if stringStartsWith(version, '0.6') then setObjectOrder("iconJake", getObjectOrder("iconP2")) else setObjectOrder("iconJake", getObjectOrder("uiGroup")) end
	end

	setTextFont("scoreTxt", "finn.ttf")
	setTextFont("timeTxt", "finn.ttf")
	runHaxeCode([[game.scoreTxt.color = FlxColor.fromRGB(game.boyfriend.healthColorArray[0],game.boyfriend.healthColorArray[1],game.boyfriend.healthColorArray[2]);]])
	runHaxeCode([[game.timeBar.leftBar.color = FlxColor.fromRGB(game.dad.healthColorArray[0],game.dad.healthColorArray[1],game.dad.healthColorArray[2]);]])
end

function onUpdatePost(elapsed)
	setProperty('iconP1.x', 614)
	setProperty('iconP2.x', 513)
	if luaSpriteExists("jake") then setProperty('iconJake.x', 513 - 350) end
	setProperty("iconPibby.x", 964)

	if dodgeMisses >= 2 then playAnim("finnBarThing", "idle1", false) end
	if dodgeMisses == 1 then playAnim("finnBarThing", "idle2", false) end
	if dodgeMisses == 0 then playAnim("finnBarThing", "idle3", false) end

	if getProperty("gf") ~= nil then scaleObject("iconPibby", getProperty("iconP1.scale.x")-0.2, getProperty("iconP1.scale.x")-0.2) setProperty("iconPibby.animation.curAnim.curFrame", getProperty("iconP1.animation.curAnim.curFrame")) end
	if luaSpriteExists("jake") then scaleObject("iconJake", getProperty("iconP2.scale.x")-0.2, getProperty("iconP2.scale.x")-0.2) setProperty("iconJake.animation.curAnim.curFrame", getProperty("iconP2.animation.curAnim.curFrame")) end

	if dodgeMisses >= 3 then
		setHealth(0)
	end
end

function noteMiss(index, noteDir, noteType, isSustainNote)
	if noteType == "Sword Note" or noteType == "Dodge Note" or noteType == "Attack Note" then
		dodgeMisses = dodgeMisses + 1;
	end
end

function onBeatHit()
	if curBeat % 4 == 0 and getProperty("jake.curAnim.animation.finished") then
		playAnim("jake", "idle")
	end
end
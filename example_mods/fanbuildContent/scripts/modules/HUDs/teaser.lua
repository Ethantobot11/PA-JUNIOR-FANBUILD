function onCreate()
	if getProperty("pauseMenuChar") == nil then
		if getProperty("storyWeekName") == "prolouge" then setProperty("pauseMenuChar", "bunbun") end
		if getProperty("storyWeekName") == "finn" then setProperty("pauseMenuChar", "finn-revealed") end
		if getProperty("storyWeekName") == "gumball" then setProperty("pauseMenuChar", "gumball") end
	end
end
function onCreatePost()
	setProperty("healthBar.visible", false)
	setProperty("healthBar.alpha", 0)
	setProperty("scoreTxt.alpha", 0)
	
	makeLuaSprite("iconP1fake", "", 614, getProperty("healthBar.y") -75)
	makeLuaSprite("iconP2fake", "", 513, getProperty("healthBar.y") -75)
	makeLuaSprite("iconP3fake", "", 700, getProperty("healthBar.y") -90)
	if songName == "Coward" then
		setProperty("iconP1fake.x", 508)
		setProperty("iconP2fake.x", 619)
		setProperty("iconP2fake.y", getProperty("healthBar.y") -105)
	end
	
	setTextFont("scoreTxt", getProperty("storyWeekName")..".ttf")
	setTextFont("timeTxt", getProperty("storyWeekName")..".ttf")
	runHaxeCode([[game.scoreTxt.color = FlxColor.fromRGB(game.boyfriend.healthColorArray[0],game.boyfriend.healthColorArray[1],game.boyfriend.healthColorArray[2]);]])
	runHaxeCode([[game.timeBar.leftBar.color = FlxColor.fromRGB(game.dad.healthColorArray[0],game.dad.healthColorArray[1],game.dad.healthColorArray[2]);]])
end

function onUpdatePost(elapsed)
	setProperty("iconP2.y", getProperty("iconP2fake.y"))
	setProperty("iconP2.x", getProperty("iconP2fake.x")-10)
	setProperty("iconP1.y", getProperty("iconP1fake.y"))
	setProperty("iconP1.x", getProperty("iconP1fake.x")+10)
	if getProperty("gf") ~= nil then
		setProperty("iconPibby.y", getProperty("iconP3fake.y"))
		setProperty("iconPibby.x", getProperty("iconP3fake.x"))
		scaleObject("iconPibby", getProperty("iconP1.scale.x")-0.2, getProperty("iconP1.scale.x")-0.2) setProperty("iconPibby.animation.curAnim.curFrame", getProperty("iconP1.animation.curAnim.curFrame"))
	end
end
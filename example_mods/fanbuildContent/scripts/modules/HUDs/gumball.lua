function onCreate() if getProperty("pauseMenuChar") == nil then setProperty("pauseMenuChar", "gumball") end end
function onCreatePost()
	setProperty("healthBar.visible", false)
	setProperty("healthBar.alpha", 0)

	makeAnimatedLuaSprite("pibbyHealthbar", "healthbar/healthbarShader", 0, 0)
	for i = 0, 40 do
		runHaxeCode([[
			var i = ]]..i..[[;
			var indiceStart = i * 3;
			var animFrames = [indiceStart, indiceStart + 1, indiceStart + 2];
			var calc = (Math.fround(((i/40)*100) / 2.5) * 2.5);
			setVar("healthCalc", (Math.fround(((i/40)*100) / 2.5) * 2.5));
		]], {i = i})
		local indiceStart = i * 3;
		local animFrames = {indiceStart, indiceStart + 1, indiceStart + 2} 
		   --pibbyHealthbar.animation.addByIndices('${CoolUtil.snap((i/40)*100, 2.5)}Percent', "healthbar", animFrames, "", 12, true);
		addAnimationByIndices("pibbyHealthbar", ""..getProperty("healthCalc").."Percent", "healthbar", ""..animFrames[1]..","..animFrames[2]..","..animFrames[3], 12, true)
	end
	setObjectCamera("pibbyHealthbar", "hud")
	setProperty("pibbyHealthbar.x", 65)
	setProperty("pibbyHealthbar.y", getProperty("iconP1.y") + 50)
	addLuaSprite("pibbyHealthbar")
	playAnim("pibbyHealthbar", "50Percent", true)
	if stringStartsWith(version, '0.6') then setObjectOrder("pibbyHealthbar", getObjectOrder("iconP1") - 1) else setObjectOrder("pibbyHealthbar", getObjectOrder("uiGroup") - 1) end
	if shadersEnabled and incompatibleShaders then
		setSpriteShader("pibbyHealthbar", "GreenReplacementShader")
		setShaderFloat("pibbyHealthbar", "rCol", getProperty("boyfriend.healthColorArray[0]") / 255)
		setShaderFloat("pibbyHealthbar", "gCol", getProperty("boyfriend.healthColorArray[1]") / 255)
		setShaderFloat("pibbyHealthbar", "bCol", getProperty("boyfriend.healthColorArray[2]") / 255)
	end

	setTextFont("scoreTxt", "gumball.ttf")
	setTextFont("timeTxt", "gumball.ttf")
	setTextBorder('timeTxt', 2, '000000')
	if downscroll then setProperty("timeTxt.y", getProperty("timeTxt.y") - 60) else setProperty("timeTxt.y", getProperty("timeTxt.y") + 60) end
	runHaxeCode([[game.scoreTxt.color = FlxColor.fromRGB(game.boyfriend.healthColorArray[0],game.boyfriend.healthColorArray[1],game.boyfriend.healthColorArray[2]);]])
	runHaxeCode([[game.timeBar.leftBar.color = FlxColor.fromRGB(game.dad.healthColorArray[0],game.dad.healthColorArray[1],game.dad.healthColorArray[2]);]])
end

function onUpdatePost(elapsed)
	setProperty('iconP1.x', 530)
	setProperty('iconP2.x', 50)
	setProperty("iconPibby.x", 530 + 75)
	setProperty('scoreTxt.y', getProperty('healthBar.y') + 40)
	setProperty('scoreTxt.x', getProperty('pibbyHealthbar.x') - 350)

	runHaxeCode([[setVar("healthBarCalc", (Math.fround((100 -game.healthBar.percent) / 2.5) * 2.5));]])
	playAnim("pibbyHealthbar", ""..getProperty("healthBarCalc").."Percent")

	if getProperty("gf") ~= nil then scaleObject("iconPibby", getProperty("iconP1.scale.x")-0.2, getProperty("iconP1.scale.x")-0.2) setProperty("iconPibby.animation.curAnim.curFrame", getProperty("iconP1.animation.curAnim.curFrame")) end

	runHaxeCode([[
		if (!game.paused && game.updateTime) {
			var curTime = Math.max(0, Conductor.songPosition - ClientPrefs.data.noteOffset);
	
			var songCalc = (game.songLength - curTime);
			songCalc = curTime;
	
			var songLength = Math.floor(game.songLength / 1000);
			if(songLength < 0) songLength = 0;
	
			var secondsTotal = Math.floor(songCalc / 1000);
			if(secondsTotal < 0) secondsTotal = 0;
	
			game.timeTxt.text = FlxStringUtil.formatTime(secondsTotal, false) + " - " + FlxStringUtil.formatTime(songLength, false);
		}
	]])
end

function onEvent(eventName, value1, value2)
	if eventName == "Change Character" then
		if value1 == "bf" then 
			if shadersEnabled and incompatibleShaders then
				setShaderFloat("pibbyHealthbar", "rCol", getProperty("boyfriend.healthColorArray[0]") / 255)
				setShaderFloat("pibbyHealthbar", "gCol", getProperty("boyfriend.healthColorArray[1]") / 255)
				setShaderFloat("pibbyHealthbar", "bCol", getProperty("boyfriend.healthColorArray[2]") / 255)
			end
		end
	end
end

function goodNoteHit(index, noteDir, noteType, isSustainNote)
	if noteType == "GF Sing" or gfSection and not isSustainNote then
		runHaxeCode([[ game.iconP1.changeIcon(game.gf.healthIcon); ]])
		runHaxeCode([[ game.getLuaObject("iconPibby").changeIcon(game.boyfriend.healthIcon); ]])
	else
		runHaxeCode([[ game.iconP1.changeIcon(game.boyfriend.healthIcon); ]])
		if getProperty("gf") ~= nil then runHaxeCode([[ game.getLuaObject("iconPibby").changeIcon(game.gf.healthIcon); ]]) end
	end
end
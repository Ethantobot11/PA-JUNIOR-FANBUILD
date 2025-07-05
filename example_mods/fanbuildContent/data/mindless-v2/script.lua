local camobjects = {"iconP1", "iconP2", "iconP3", "iconPibby", "scoreTxt"}
function onCreate()
	if getProperty("pauseMenuChar") == nil then setProperty("pauseMenuChar", "finn-revealed") end
	addCharacterToList("finn-sword", "dad")
	--startSongCredits (just disables song credit)
end
function onCreatePost()
	for i = 1, #camobjects do setProperty(camobjects[i]..".alpha", 0) end
	setProperty("blackie.alpha", 1)
	
	setProperty("isCameraOnForcedPos", true)
	setProperty("camFollow.x", getDADcam()[1] + 275)
	setProperty("camFollow.y", getDADcam()[2] - 15)
	setProperty("camGame.zoom", 0.6)
	setProperty("defaultCamZoom", 0.6)
	runHaxeCode([[game.iconP1.changeIcon("bf-old");]])
end

function onSongStart()
	setProperty("camHUD.alpha", 0)
	doTweenAlpha("blackie", "blackie", 0, 11 / playbackRate, "sineInOut")
	doTweenAlphaDelay("camHUDA", "camHUD", 1, 2 / playbackRate, "sineInOut", 6)
end

function onStepHit()
	if curStep == 46 then
		setProperty("isCameraOnForcedPos", false)
		setProperty("defaultCamZoom", 0.75)
	end

	if curStep == 304 then --LAUGHING
		setProperty("isCameraOnForcedPos", true)

		doTweenY("cinematicup", "cinematicup", -360 + 110, 0.35 / playbackRate, "sineInOut")
		doTweenY("cinematicdown", "cinematicdown", screenHeight - 110, 0.35 / playbackRate, "sineInOut")

		doTweenX("gotoDADx", "camFollow", getDADcam()[1], 0.35 / playbackRate, "smootherStepOut")
		doTweenY("gotoDADy", "camFollow", getDADcam()[2] + 5, 0.35 / playbackRate, "smootherStepOut")
		setProperty("cameraSpeed", 1000)

		doTweenCameraZoom("camOut", 0.95, 0.35 / playbackRate, "smootherStepOut", false)
	end

	if curStep == 337 then
		--callScript("scripts/Base HUD", "startSongCredits", {4})
		setProperty("isCameraOnForcedPos", false)
		setProperty("cameraSpeed", 2.75)

		setProperty("cinematicup.y", -360) setProperty("cinematicdown.y", screenHeight)

		cameraFlash("hud", "FFFFFF", 1.5 / playbackRate)
		doTweenCameraZoom("camOut", 0.76, 1.5 / playbackRate, "sineInOut", false)
	end

	if curStep == 402 then
		setProperty("defaultCamZoom", 0.8)
	end

	if curStep == 434 then
		setProperty("defaultCamZoom", 0.86)
	end

	if curStep == 456 then --JOIN ME BOYFRIEND!
		setProperty("isCameraOnForcedPos", true)
		doTweenY("cinematicup", "cinematicup", -360 + 140, 0.35 / playbackRate, "smootherStepOut")
		doTweenY("cinematicdown", "cinematicdown", screenHeight - 140, 0.35 / playbackRate, "smootherStepOut")

		doTweenX("gotoDADx", "camFollow", getDADcam()[1], 0.35 / playbackRate, "smootherStepOut")
		doTweenY("gotoDADy", "camFollow", getDADcam()[2], 0.35 / playbackRate, "smootherStepOut")
		setProperty("cameraSpeed", 1000)

		doTweenCameraZoom("camOutwww", 1.075, 0.35 / playbackRate, "smootherStepOut", true)
	end

	if curStep == 466 then
		setProperty("isCameraOnForcedPos", false)
		setProperty("cameraSpeed", 2.75)

		setProperty("cinematicup.y", -360) setProperty("cinematicdown.y", screenHeight)

		cameraFlash("hud", "FFFFFF", 1.5 / playbackRate)
		setProperty("defaultCamZoom", 0.8)

		setProperty("iconP2.alpha", 1)
		setProperty("iconP1.alpha", 1)
		setProperty("scoreTxt.alpha", 1)
	end

	if curStep == 724 then
		cameraFlash("hud", "FFFFFF", 1.5 / playbackRate)
		setProperty("cinematicup.y", -360 + 95) setProperty("cinematicdown.y", screenHeight - 95)

		setProperty("isCameraOnForcedPos", true)
		runHaxeCode([[game.camFollow.setPosition(]]..getDADcam()[1]..[[, ]]..getDADcam()[2]..[[); FlxG.camera.snapToTarget();]])
	end
	if curStep == 725 then setProperty("isCameraOnForcedPos", false) end

	if curStep == 737 then
		setProperty("defaultCamZoom", 0.93)
	end

	if curStep == 789 then
		setProperty("isCameraOnForcedPos", true)
		runHaxeCode([[game.camFollow.setPosition(]]..getBFcam()[1]..[[, ]]..getBFcam()[2]..[[); FlxG.camera.snapToTarget();]])
		--setProperty("defaultCamZoom", 1.05)
		cameraFlash("hud", "FFFFFF", 1.5 / playbackRate)
	end
	if curStep == 790 then setProperty("isCameraOnForcedPos", false) end
	if curStep == 801 then setProperty("defaultCamZoom", 1.2) end
	if curStep == 805 then setProperty("defaultCamZoom", 1) end
	if curStep == 822 then setProperty("defaultCamZoom", 1.2) end
	if curStep == 832 then
		doTweenY("cinematicup", "cinematicup", -360 + 40, 0.4 / playbackRate, "sineInOut")
		doTweenY("cinematicdown", "cinematicdown", screenHeight - 40, 0.4 / playbackRate, "sineInOut")
	end
	if curStep == 837 then setProperty("defaultCamZoom", 1.3) 
		setProperty("dadGroup.x", 190)
		setProperty("dadGroup.y", 250)
		triggerEvent("Change Character", "dad", "finn-sword")
		setProperty("opponentCameraOffset", {10, -30})
	end
	if curStep == 845 then 
		setProperty("defaultCamZoom", 1) 
		doTweenY("cinematicup", "cinematicup", -360 + 20, 0.4 / playbackRate, "sineInOut")
		doTweenY("cinematicdown", "cinematicdown", screenHeight - 20, 0.4 / playbackRate, "sineInOut") 
	end
	if curStep == 853 then
		setProperty("defaultCamZoom", .7)
		doTweenY("cinematicup", "cinematicup", -360, 0.2 / playbackRate, "sineInOut")
		doTweenY("cinematicdown", "cinematicdown", screenHeight, 0.2 / playbackRate, "sineInOut")
	end
	if curStep == 860 then
		cameraFlash("hud", "FFFFFF", 1.5 / playbackRate)
		setProperty("defaultCamZoom", 0.8)
				
		setProperty("isCameraOnForcedPos", true)
		runHaxeCode([[game.camFollow.setPosition(]]..getDADcam()[1]..[[, ]]..getDADcam()[2]..[[); FlxG.camera.snapToTarget();]])
	end
	if curStep == 861 then setProperty("isCameraOnForcedPos", false) end
	if curStep == 1119 then --UGH
		setProperty("defaultCamZoom", 1.1)
		doTweenY("cinematicup", "cinematicup", -360 + 80, 0.2 / playbackRate, "sineInOut")
		doTweenY("cinematicdown", "cinematicdown", screenHeight - 80, 0.2 / playbackRate, "sineInOut")
	end

	if curStep == 1124 then --JUST FIGHT ME ALREADY
		setProperty("opponentCameraOffset", {0, -35})
		setProperty("defaultCamZoom", 1.25)
		doTweenY("cinematicup", "cinematicup", -360 + 120, 0.35 / playbackRate, "sineInOut")
		doTweenY("cinematicdown", "cinematicdown", screenHeight - 120, 0.35 / playbackRate, "sineInOut")
	end

	if curStep == 1134 then --GOES TO BATTLE
 		setProperty("isCameraOnForcedPos", true)

		doTweenX("gotoDADx", "camFollow", getDADcam()[1] + 300, 1.2 / playbackRate, "smootherStepOut")
		doTweenY("gotoDADy", "camFollow", getDADcam()[2] -15, 1.2 / playbackRate, "smootherStepOut")
		setProperty("cameraSpeed", 1000)

		doTweenY("cinematicup", "cinematicup", -360 + 80, 0.35 / playbackRate, "sineInOut")
		doTweenY("cinematicdown", "cinematicdown", screenHeight - 80, 0.35 / playbackRate, "sineInOut")

		doTweenCameraZoom("camOutwww", 0.6, 0.35 / playbackRate, "sineInOut", true)
	end

	if curStep == 1135 then cameraFlash("hud", "FFFFFF", 1.5 / playbackRate) end

	if curStep == 1259 then
		doTweenAlpha("blackie", "blackie", 1, 1 / playbackRate, "sineInOut")
		doTweenAlpha("camHUDA", "camHUD", 0, 1 / playbackRate, "sineInOut")
		doTweenCameraZoom("camOutwww", 1.1, 1.5 / playbackRate, "sineInOut", true)
	end

	if curStep == 1280 then
		setProperty("cameraSpeed", 2.75)
		setProperty("isCameraOnForcedPos", false)
		for i = 1, #camobjects do setProperty(camobjects[i]..".alpha", 0) end
		setProperty("light.color", "000000")
		setProperty("lightShade.alpha", 0.0001)
		setProperty("wires.alpha", 0.0001)
		doTweenAlpha("camHUDA", "camHUD", 1, 2.2 / playbackRate, "sineInOut")
		doTweenAlpha("blackie", "blackie", 0.65, 2.2 / playbackRate, "sineInOut")
		setProperty("boyfriend.alpha", 0.2)
	
		setProperty("dadGroup.x", 65)
		setProperty("dadGroup.y", 280)

		setProperty("opponentCameraOffset", {0, -60})
		setProperty("defaultCamZoom", 0.82)
	end
	
	if curStep == 1538 then
		setProperty("blackie.alpha", 0)
		setProperty("light.color", getColorFromHex("FFFFFF"))
		setProperty("lightShade.alpha", 1)
		setProperty("wires.alpha", 1)
		triggerEvent("Apple Filter", "off")
		cameraFlash("hud", "FFFFFF", 1.5 / playbackRate)
	end

	if curStep == 1639 then 
		setProperty("dadGroup.x", 190)
		setProperty("dadGroup.y", 250)
		triggerEvent("Change Character", "dad", "finn-sword")
		setProperty("opponentCameraOffset", {10, -30})

		setProperty("defaultCamZoom", 0.86)
	end
	if curStep == 1649 then setProperty("defaultCamZoom", 0.92) end
	if curStep == 1667 then
		doTweenY("cinematicup", "cinematicup", -360 + 90, 0.7 / playbackRate, "sineInOut")
		doTweenY("cinematicdown", "cinematicdown", screenHeight - 90, 0.7 / playbackRate, "sineInOut")
		setProperty("defaultCamZoom", 0.95)
	end
	if curStep == 1667 then
		doTweenY("cinematicup", "cinematicup", -360 + 130, 0.7 / playbackRate, "sineInOut")
		doTweenY("cinematicdown", "cinematicdown", screenHeight - 130, 0.7 / playbackRate, "sineInOut")
		setProperty("defaultCamZoom", 1.15)
	end

	if curStep == 1681 then
		cameraFlash("hud", "FFFFFF", 1.5 / playbackRate)
		setProperty("defaultCamZoom", 0.82)
		setProperty("boyfriend.alpha", 1)
		setProperty("cinematicup.y", -360)
		setProperty("cinematicdown.y", screenHeight)
	end
	if curStep == 1681 or curStep == 1694 or curStep == 1712 or curStep == 1726 or curStep == 1744 or curStep == 1758 then
		setProperty("defaultCamZoom", 1)
		setProperty("camGame.zoom", 1)
		doTweenCameraZoom("camOutwww", 0.82, 0.7 / playbackRate, "sineInOut", true)
		
		setProperty("whitey.alpha", 0.2)
		doTweenAlpha("whiteyA", "whitey", 0, 0.75 / playbackRate, "cubeInOut")
	end

	if curStep == 1936 then
		cameraFlash("hud", "FFFFFF", 1.5 / playbackRate)
		setProperty("isCameraOnForcedPos", true)

		setProperty("camFollow.x", getDADcam()[1] + 275)
		setProperty("camFollow.y", getDADcam()[2] - 15)
		setProperty("cinematicup.y", -360 + 40)
		setProperty("cinematicdown.y", screenHeight - 40)
		setProperty("defaultCamZoom", 0.6)
	end

	if curStep == 2001 then
		cameraFlash("hud", "FFFFFF", 1.5 / playbackRate)
		setProperty("isCameraOnForcedPos", false)
		setProperty("defaultCamZoom", 0.82)
	end

	if curStep == 2481 then
		cameraFlash("hud", "FFFFFF", 1 / playbackRate)
		setProperty("defaultCamZoom", 1)
		setProperty("camGame.zoom", 1)
	end
	if curStep == 2488 then
		setProperty("defaultCamZoom", 1.2)
		doTweenY("cinematicup", "cinematicup", -360 + 130, 0.7 / playbackRate, "sineInOut")
		doTweenY("cinematicdown", "cinematicdown", screenHeight - 130, 0.7 / playbackRate, "sineInOut")
	end
	if curStep == 2513 then
		setProperty("defaultCamZoom", 1)
		setObjectCamera("blackie", "other")
		doTweenAlpha("blackie", "blackie", 1, 1.4 / playbackRate, "sineInOut")
		doTweenY("cinematicup", "cinematicup", -360 + 40, 0.7 / playbackRate, "sineInOut")
		doTweenY("cinematicdown", "cinematicdown", screenHeight - 40, 0.7 / playbackRate, "sineInOut")
	end
	if curStep == 2536 then
		cameraFlash("other", "FFFFFF", 1 / playbackRate)
	end
end
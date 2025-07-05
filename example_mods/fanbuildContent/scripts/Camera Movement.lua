--WARNING READ THIS!!
--WARNING READ THIS!!

--
--THIS CODE IS BY JUNIORNOVOA (YXERX)
--

--WARNING READ THIS!!
--WARNING READ THIS!!
local newFollowPos = {["x"] = 0, ["y"] = 0}
local animOffsetValue = 20;

function math.lerp(a, b, ratio) return a + ratio * (b - a); end
function boundTo(value, min, max) return math.max(min, math.min(max, value));end

local charArrays = {["boyfriend"] = {0,0},["dad"] = {0,0},["gf"] = {0,0},["jake"] = {0,0}}
function setCharCamPositions()
	charArrays = {
	["boyfriend"] = getBFcam(), 
	["dad"] = getDADcam(),
	["gf"] = {0,0},
	["jake"] = {0,0}
	}
	if getProperty("gf") ~= nil then charArrays["gf"] = getGFcam() end
	if luaSpriteExists("jake") then charArrays["jake"] = {getMidpointX('jake') + 150 + getProperty('jake.cameraPosition[0]') - getProperty('opponentCameraOffset[0]'),getMidpointY('jake') - 100 + getProperty('jake.cameraPosition[1]') + getProperty('opponentCameraOffset[1]')}; end
	if songName == "Come Along With Me" then
		charArrays["boyfriend"] = {1710, 2290};
		charArrays["dad"] = {1710, 2290};
	end
end

function onCreate()
	setVar("focusOnGF", false)
end
function onCountdownStarted()
	runHaxeCode([[game.setOnLuas('mustHitSection', true);]])
end

function onUpdate(elapsed)
	setCharCamPositions()
	local charAnimOffsetX = 0;
	local charAnimOffsetY = 0;
	local focusedCharacter = "boyfriend"
	if gfSection or (mustHitSection and getVar("focusOnGF")) then focusedCharacter = "gf" end
	if not mustHitSection then focusedCharacter = "dad" end
	if not mustHitSection and luaSpriteExists("jake") then
		if getProperty("jake.animation.curAnim.name") ~= "idle" then focusedCharacter = "jake" end 
	end
	local focusedCharacterAnim = getProperty(focusedCharacter..".animation.curAnim.name")

	if focusedCharacter == "dad" and dadName == "FINNPHASE2" and getProperty("defaultCamZoom") <= 0.9 and getProperty("defaultCamZoom") >= 0.4 then
		charArrays["dad"][1] = charArrays["dad"][1] + (100 / getProperty("defaultCamZoom"))
		charArrays["dad"][2] = charArrays["dad"][2] - (50 / getProperty("defaultCamZoom"))
	end

	if string.match(focusedCharacterAnim, "UP") or string.match(focusedCharacterAnim, "UP-alt") or string.match(focusedCharacterAnim, "UPmiss") then
		charAnimOffsetY = charAnimOffsetY - animOffsetValue;
	end
	if string.match(focusedCharacterAnim, "DOWN") or string.match(focusedCharacterAnim, "DOWN-alt") or string.match(focusedCharacterAnim, "DOWNmiss") then
		charAnimOffsetY = charAnimOffsetY + animOffsetValue;
	end
	if string.match(focusedCharacterAnim, "LEFT") or string.match(focusedCharacterAnim, "LEFT-alt") or string.match(focusedCharacterAnim, "LEFTmiss") then
		charAnimOffsetX = charAnimOffsetX - animOffsetValue;
	end
	if string.match(focusedCharacterAnim, "RIGHT") or string.match(focusedCharacterAnim, "RIGHT-alt") or string.match(focusedCharacterAnim, "RIGHTmiss") then
		charAnimOffsetX = charAnimOffsetX + animOffsetValue;
	end

	local lerpVal = boundTo(elapsed * 2.4 * getProperty("cameraSpeed") * playbackRate, 0, 1);
	newFollowPos["x"] = math.lerp(getProperty("camFollow.x"), charArrays[focusedCharacter][1] + charAnimOffsetX, lerpVal)
	newFollowPos["y"] = math.lerp(getProperty("camFollow.y"), charArrays[focusedCharacter][2] + charAnimOffsetY, lerpVal)

	if getProperty("inCutscene") or getProperty("isCameraOnForcedPos") or inGameOver then setPropertyFromClass("flixel.FlxG", "camera.followLerp", 2.4 * getProperty("cameraSpeed") * playbackRate) return; end
	setPropertyFromClass("flixel.FlxG", "camera.followLerp", 100)
	setProperty("camFollow.x", newFollowPos["x"]) -- overrides original camfollow pos
	setProperty("camFollow.y", newFollowPos["y"]) -- even if no lerping is going on

	local angleLerp = boundTo(boundTo(elapsed * 2.4 / 0.4, 0, 1) * getProperty("cameraSpeed") * playbackRate, 0, 1);
	setProperty("camGame.angle", math.lerp(getProperty("camGame.angle"), 0 + charAnimOffsetX / 30, angleLerp))
end

function onUpdatePost(elapsed)
	if getProperty("inCutscene") or getProperty("isCameraOnForcedPos") or inGameOver then setPropertyFromClass("flixel.FlxG", "camera.followLerp", 2.4 * getProperty("cameraSpeed") * playbackRate) return; end
	setProperty("camFollow.x", newFollowPos["x"]) -- overrides original camfollow pos
	setProperty("camFollow.y", newFollowPos["y"]) -- even if no lerping is going on
end
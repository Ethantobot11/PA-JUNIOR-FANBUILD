local pathName = "lab-old";
function onCreate()
	makeLuaSprite('bg', "stages/"..pathName..'/lablight', -410, -910)
	addLuaSprite('bg', false)
	scaleObject('bg', 1.4, 1.4)
	setScrollFactor('bg', 1, 1)

	makeLuaSprite('light', "stages/"..pathName..'/bulb', -410, -910)
	addLuaSprite('light', true)
	scaleObject('light', 1.4, 1.4)
	setScrollFactor('light', 1, 1)

	makeLuaSprite('lightShade', "stages/"..pathName..'/dark', -410, -910)
	addLuaSprite('lightShade', true)
	scaleObject('lightShade', 1.4, 1.4)
	setScrollFactor('lightShade', 1, 1)

	makeLuaSprite('wires', "stages/"..pathName..'/glitch', -410, -910)
	addLuaSprite('wires', true)
	scaleObject('wires', 1.4, 1.4)
	setScrollFactor('wires', 1, 1)
end

local elapsedtotal = 0;
function onUpdate(elapsed)
	elapsedtotal = elapsedtotal + elapsed;

	setProperty("light.alpha", 1 - (math.sin(elapsedtotal * 8)))
	setProperty("lightShade.angle", -1 + (math.sin(elapsedtotal * 1.2) * 2))
end
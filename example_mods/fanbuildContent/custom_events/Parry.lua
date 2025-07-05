function onCreate()
    precacheSound("parry1")
    precacheSound("parry2")
    addCharacterToList("finn-slash", "dad")
    addCharacterToList("bfsword", "boyfriend")
end
function onCreatePost()
    makeAnimatedLuaSprite("parry", "mechanic/parry", 0, 0)
    addAnimationByPrefix("parry", "idle", "Parry000", 12, true)
    addAnimationByIndices("parry", "hit", "Parry000", {0,1,2}, 12)
    setObjectCamera("parry", "hud")
    scaleObject("parry", 0.9, 0.9, true)
    updateHitbox("parry")
    screenCenter("parry")
    addLuaSprite("parry", false)
    playAnim("parry", "idle")
    setProperty("parry.alpha", 0.0001)

    makeLuaSprite("gradientParry", "gradient", 0, 0)
    setGraphicSize("gradientParry", 1280, 720, true)
    screenCenter("gradientParry")
    setObjectCamera("gradientParry", "hud")
    addLuaSprite("gradientParry", false)
    setProperty("gradientParry.alpha", 0.0001)
end

local timeTillParryCheck = 1 / playbackRate;
local parryCooldown = 0.5 * playbackRate;
function eventEarlyTrigger(name)
    if name == "Parry" then
        return -2000;
    end
end

local singAnims = {"singLEFT", "singDOWN", "singUP", "singRIGHT"}
local canParry = false;
local parried = false;

function onUpdate(elapsed)
    if keyboardJustPressed("SPACE") and canParry then
        canParry = false;
        parried = true;
        setProperty("boyfriend.debugMode", false)
        playAnim("boyfriend", singAnims[getRandomInt(1, 3, "2")], true)
        setProperty("boyfriend.debugMode", true)
        setProperty("boyfriend.specialAnim", true)
        setProperty("boyfriend.holdTimer", 0)
        playAnim("parry", "hit")
        runTimer("parryCooldown", parryCooldown)
    end
end

local oldChars = {};
local prevdadGroupX = 0;
function onEvent(eventName, value1, value2)
    if eventName == "Parry" then
        canParry = true;
        parried = false;

        doTweenAlpha('parry', "parry", 1, 0.1 / playbackRate, "sineInOut")
        oldChars[1] = dadName; oldChars[2] = boyfriendName;
        triggerEvent("Change Character", "dad", "finn-slash")
        characterDance("dad")
        setProperty("dad.debugMode", true)
        triggerEvent("Change Character", "boyfriend", "bfsword")
        characterDance("boyfriend")
        setProperty("boyfriend.debugMode", true)
        prevdadGroupX = getProperty("dadGroup.x")
        doTweenX("dadGroupMoveToBF", "dadGroup", getProperty("boyfriendGroup.x") -950, timeTillParryCheck - 0.01, "sineInOut")

        doTweenAlpha("gradientParry", "gradientParry", 0.7, timeTillParryCheck - 0.01, "sineInOut")
        runTimer("checkIfParried", timeTillParryCheck)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == "parryCooldown" then
        playAnim("parry", "idle")
        setProperty("boyfriend.debugMode", false)
        characterDance("boyfriend")
        setProperty("boyfriend.debugMode", true)
        canParry = true;
        parried = false;
    end
    if tag == "checkIfParried" then
        cancelTimer("parryCooldown")
        canParry = false;

        setProperty("boyfriend.debugMode", false)
        setProperty("dad.debugMode", false)
        playAnim("dad", singAnims[3], true)
        setProperty("dad.debugMode", true)

        setProperty("parry.alpha", 0.0001)
        setProperty("gradientParry.alpha", 0.0001)
        if parried then
            setProperty("whitey.alpha", getProperty("whitey.alpha") + 0.4)
            doTweenAlpha("whitey", "whitey", getProperty("whitey.alpha")-0.4, 0.6 / playbackRate, "cubeInOut")
            playSound("parry"..getRandomInt(1, 2))
        else
            setProperty("blackie.alpha", getProperty("blackie.alpha") + 0.4)
            doTweenAlpha("blackie", "blackie", getProperty("blackie.alpha")-0.4, 0.6 / playbackRate, "cubeInOut")
            playAnim("boyfriend", singAnims[getRandomInt(1, 3)].."miss", true)
            --setHealth(getHealth() - 1)
        end

        setProperty("boyfriend.debugMode", true)
        runTimer("switchCharsBack", 0.7 / playbackRate)
    end
    if tag == "switchCharsBack" then
        setProperty("dad.debugMode", false)
        setProperty("boyfriend.debugMode", false)
        doTweenX("dadGroupMoveAwayFromBF", "dadGroup", prevdadGroupX, 0.5 / playbackRate, "sineInOut")

        triggerEvent("Change Character", "dad", oldChars[1])
        triggerEvent("Change Character", "boyfriend", oldChars[2])
    end
end
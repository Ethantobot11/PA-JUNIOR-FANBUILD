local stuff = {'angle', 'alpha'}

function onCreatePost()
    makeAnimatedLuaSprite('finnIcon', 'icons/icon-finn-animated', 0, 0)
    addAnimationByPrefix('finnIcon', 'idle', 'normal', 8, true);
    addAnimationByPrefix('finnIcon', 'losing', 'losing', 8, true);
    addOffset("finnIcon", "idle", 0, 0)
    addOffset("finnIcon", "losing", -75, -128)
    playAnim('finnIcon', 'idle', true)
    scaleObject("finnIcon", 0.5)
    setObjectCamera('finnIcon', 'hud')
    addLuaSprite('finnIcon', false)
    screenCenter("finnIcon")
    setObjectOrder('finnIcon', getObjectOrder('uiGroup')-1)
end

local stupidshit = true;
function onEvent(eventName, value1, value2)
    if eventName == "Change Character" then
        if value1 == "dad" then
            if string.lower(value2) == "finnphase2-old" or string.lower(value2) == "finn-sword" or string.lower(value2) == "finn-slash" or string.lower(value2) == "finn-hurting" then
                stupidshit = true;
            else
                stupidshit = false;
                setProperty("finnIcon.visible", false)
                setProperty('iconP2.visible', true)
            end
        end
    end
end

function onUpdate()
    --setProperty("camHUD.zoom", 0.5)
    if not stupidshit then return; end
    if getProperty("iconP2.animation.curAnim.curFrame") == 0 then playAnim("finnIcon", "idle", false) else playAnim("finnIcon", "losing", false, true) end

    setProperty("finnIcon.visible", true)
    setProperty('iconP2.visible', false)
    setProperty("finnIcon.alpha", getProperty("iconP2.alpha"))
    setProperty("finnIcon.scale.x", getProperty("iconP2.scale.x") * 0.35)
    setProperty("finnIcon.scale.y", getProperty("iconP2.scale.y") * 0.35)

    setProperty("finnIcon.x", getProperty("iconP2.x")-350)
    setProperty("finnIcon.y", getProperty("iconP2.y")+50)

    setProperty("finnIcon.x", getProperty("iconP2.x")-800)
    setProperty("finnIcon.y", getProperty("iconP2.y")-625)
end
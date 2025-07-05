function onEvent(eventName, value1, value2)
    if eventName == "switchStageLights" then
        if string.find(string.lower(value1), "true") then
            callScript("stages/lab", "lightBG")
            setStrumsSkin("NOTE_assets")
        else
            callScript("stages/lab", "darkBG")
            setStrumsSkin("NOTE_assets_dark")
        end

        if string.find(string.lower(value1), "true") then
            setProperty("lightOverCast.visible", true)
	        setProperty("light.visible", true)
        else
        	setProperty("lightOverCast.visible", false)
	        setProperty("light.visible", false)
        end
    end
end
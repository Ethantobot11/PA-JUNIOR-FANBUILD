function onEvent(eventName, value1, value2)
    if eventName == "Set Camera Zoom" then
        setProperty("defaultCamZoom", value1)
        if value2 == "true" then setProperty("camGame.zoom", value1) end
    end
end
--to whoever is looking at this, yes this code is ass, and yes its holding on by a thread
local MODULES_PATH = "scripts/modules/"
local RUNNING_MODULES = {};

function init_module(name, fileType)
	--print("\nNEW MODULE PATH: ("..MODULES_PATH..name..")")
	if string.lower(fileType) == "lua" then 
		addLuaScript(MODULES_PATH..name..".lua")
	else
		addHScript(MODULES_PATH..name..".hx")
	end
	--callScript(MODULES_PATH..name, "onCreate")
	table.insert(RUNNING_MODULES, MODULES_PATH..name.."."..fileType)
end

local hudModuleInitialized = false;
function init_HUD_module(name)
	if hudModuleInitialized then print("a HUD Module is already initialized, not running ("..name..").") return; end
	print("INITIALIZING: ("..name..".lua) HUD MODULE.")
	hudModuleInitialized = true;
	init_module("HUDs/"..name, "lua")
end

function init_modules_in_directory(dir)
	local files = directoryFileList("mods/fanbuildContent/"..MODULES_PATH..dir)
	for i = 1, #files do
		local fileName = string.gsub(files[i], ".lua", "")
		if checkFileExists(MODULES_PATH..dir.."/"..fileName..".lua") then
			print("\nINITIALIZING: ("..files[i]..") "..string.upper(dir).." MODULE.")
			init_module(dir.."/"..fileName, "lua")
		end
		local fileName = string.gsub(files[i], ".hx", "")
		if checkFileExists(MODULES_PATH..dir.."/"..fileName..".hx") then
			print("\nINITIALIZING: ("..files[i]..") "..string.upper(dir).." MODULE.")
			init_module(dir.."/"..fileName, "hx")
		end
	end
end

function onCreate()
	print("\nM O D U L E     M A N A G E R\n--- --- --- --- --- --- --- --- --- --- --- --- --- --- ---")

	if songName == "Child's Play" or songName == "My Amazing World" or songName == "Mindless" then --overrides week hud modules
		init_HUD_module("teaser")
	end
	if songName == "Mindless v2" then init_HUD_module("teaser old") end

	if checkFileExists(MODULES_PATH.."HUDs/"..getProperty("storyWeekName")..".lua") then
		init_HUD_module(getProperty("storyWeekName"))
	else
		init_HUD_module("teaser")
	end

	init_modules_in_directory("Callbacks")
	init_modules_in_directory("Misc")
	if not debugBuild then init_modules_in_directory("Release") end
	init_modules_in_directory("Debug")

	print("\nRunning Modules: ("..MODULES_PATH..")")
	for i = 1, #RUNNING_MODULES do
		print(" - "..string.gsub(RUNNING_MODULES[i], MODULES_PATH, ""))
	end
	print("--- --- --- --- --- --- --- --- --- --- --- --- --- --- ---")
end
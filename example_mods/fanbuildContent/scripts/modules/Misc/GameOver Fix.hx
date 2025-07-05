//WARNING READ THIS!!
//WARNING READ THIS!!

//
//THIS CODE IS BY JUNIORNOVOA (YXERX)
//

//WARNING READ THIS!!
//WARNING READ THIS!!
import flixel.sound.FlxSound;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import openfl.display.Sprite;
import openfl.display.StageAlign;
import openfl.display.StageScaleMode;
import openfl.Lib;
import Std;
import flixel.tweens.misc.NumTween;
import sys.io.Process;

import psychlua.LuaUtils;
import psychlua.DebugLuaText;
import psychlua.ModchartSprite;

import substates.GameOverSubstate;

function onCreatePost()
{
	if (!gore)
	{
		GameOverSubstate.characterName = 'bf-dead';
		GameOverSubstate.deathSoundName = 'fnf_loss_sfx';
		GameOverSubstate.loopSoundName = 'gameOver';
		GameOverSubstate.endSoundName = 'gameOverEnd';
	}
}

function onGameOverStart()
{
	game.camGame.setFilters([]);
	game.camHUD.setFilters([]);

	var instance = GameOverSubstate.instance;
	var boyfriend = instance.boyfriend;
	instance.camFollow.setPosition(boyfriend.getMidpoint().x - 100, boyfriend.getMidpoint().y - 100);
	instance.camFollow.x -= boyfriend.cameraPosition[0];
	instance.camFollow.y += boyfriend.cameraPosition[1];

	FlxG.camera.focusOn(new FlxPoint(instance.camFollow.x, instance.camFollow.y));
}
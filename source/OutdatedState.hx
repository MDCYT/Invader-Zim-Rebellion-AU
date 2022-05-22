package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class OutdatedState extends MusicBeatState
{
	public static var leftState:Bool = false;
	var bg:FlxSprite;
	var blackbg:FlxSprite;
	var warnTitle:FlxText;
	var warnText:FlxText;
	var titleNewFeatures:FlxText;
	var newFeatures:FlxText;
	var anyWayButton:FlxText;

	override function create()
	{
		super.create();

		bg = new FlxSprite().loadGraphic(Paths.image('outdate/background'));
		add(bg);

		blackbg = new FlxSprite().loadGraphic(Paths.image('outdate/black'));
		blackbg.alpha = 0.5;
		blackbg.screenCenter();
		add(blackbg);

		warnTitle = new FlxText(0, 0, FlxG.width, "HI FRIEND!");
		warnTitle.setFormat("Arca Majora 3 Bold", 30, FlxColor.WHITE, CENTER);
		warnTitle.screenCenter(X);
		warnTitle.y += 160;
		add(warnTitle);

		warnText = new FlxText(0, 0, FlxG.width,
			"You are using a outdated version of this mod (" + MainMenuState.gameVersion + "),\n" +
			"please update to " + TitleState.updateVersion + "!",
			32);
		warnText.setFormat("Courier New", 28, FlxColor.WHITE, CENTER);
		warnText.screenCenter(X);
		warnText.y += 240;

		add(warnText);

		titleNewFeatures = new FlxText(0, 0, FlxG.width, "NEW FEATURES:");
		titleNewFeatures.setFormat("Courier New", 28, FlxColor.WHITE, CENTER);
		titleNewFeatures.screenCenter(X);
		titleNewFeatures.y += warnText.y + warnText.height + 40;
		add(titleNewFeatures);

		newFeatures = new FlxText(0, 0, FlxG.width, TitleState.newVersionData);
		newFeatures.setFormat("Courier New", 28, FlxColor.WHITE, CENTER);
		newFeatures.bold = true;
		newFeatures.screenCenter(X);
		newFeatures.y += titleNewFeatures.y + titleNewFeatures.height + 5;
		add(newFeatures);

		anyWayButton = new FlxText(0, 0, FlxG.width, "Please [ESC] to proceed anyway.");
		anyWayButton.setFormat("Courier New", 28, FlxColor.WHITE, CENTER);
		anyWayButton.bold = true;
		anyWayButton.screenCenter(X);
		anyWayButton.y += newFeatures.y + newFeatures.height + 100;
		add(anyWayButton);


		
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			if (controls.ACCEPT) {
				leftState = true;
				CoolUtil.browserLoad("https://github.com/ShadowMario/FNF-PsychEngine/releases");
			}
			else if(controls.BACK) {
				leftState = true;
			}

			if(leftState)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				FlxTween.tween(bg, {alpha: 0}, 1);
				FlxTween.tween(blackbg, {alpha: 0}, 1);
				FlxTween.tween(warnTitle, {alpha: 0}, 1);
				FlxTween.tween(warnText, {alpha: 0}, 1);
				FlxTween.tween(titleNewFeatures, {alpha: 0}, 1);
				FlxTween.tween(newFeatures, {alpha: 0}, 1);
				FlxTween.tween(anyWayButton, {alpha: 0}, 1, {
					onComplete: function (twn:FlxTween) {
						MusicBeatState.switchState(new MainMenuState());
					}
				});
			}
		}
		super.update(elapsed);
	}
}

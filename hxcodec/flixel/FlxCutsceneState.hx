package hxcodec.flixel;

import flixel.FlxG;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;

/**
 * A simple utility class providing an easy way to play an in-game cutscene.
 */
class FlxCutsceneState extends FlxVideoState
{
  /**
   * Users can press any of these keys to skip the cutscene.
   */
  public var skipKeys:Array<FlxKey> = [FlxKey.SPACE, FlxKey.ENTER, FlxKey.ESCAPE];

  var nextState:FlxState;

  public function new(path:String, nextState:FlxState)
  {
    super(path, false, false);

    this.nextState = nextState;
  }

  public override function create():Void
  {
    super.create();

    // Move to next state if video finishes.
    video.onEndReached.add(onVideoEnded);
  }

  public override function update(elapsed:Float):Void
  {
    super.update(elapsed);

    // Move to next state if user presses a skip key.
    if (FlxG.keys.anyJustPressed(skipKeys))
    {
      onVideoEnded();
    }
  }

  function onVideoEnded():Void
  {
    video.stop();

    // This null check means that if the next state is null,
    // the game will stay on the cutscene state.
    if (nextState != null) {
      FlxG.switchState(nextState);
    } else {
      trace('[ERROR] FlxCutsceneState has nowhere to go!');
    }
  }
}

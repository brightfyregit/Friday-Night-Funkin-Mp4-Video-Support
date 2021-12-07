package;

import flixel.FlxSprite;

class MP4Sprite extends FlxSprite
{
	public var readyCallback:Void->Void;
	public var finishCallback:Void->Void;

	var video:MP4Handler;

	public function new(x:Float, y:Float)
	{
		super(x, y);

		video = new MP4Handler();
		video.alpha = 0;

		video.readyCallback = function()
		{
			loadGraphic(video.bitmapData);

			if (readyCallback != null)
				readyCallback();
		}

		video.finishCallback = function()
		{
			if (finishCallback != null)
				finishCallback();

			destroy();
		};
	}

	/**
	 * Native video support for Flixel & OpenFL
	 * @param path Example: `your/video/here.mp4`
	 * @param repeat Repeat the video.
	 */
	public function playVideo(path:String, ?repeat:Bool = false)
	{
		video.playVideo(path, repeat);
	}

	public function pause()
	{
		video.pause();
	}

	public function resume()
	{
		video.resume();
	}
}

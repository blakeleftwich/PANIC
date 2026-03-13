class Glove extends MovieClip
{

function Glove()
{
_x = Stage.width/2;
_y = Stage.height/2;

}

function onEnterFrame()
{
	//move();
	checkCollision();
	
}

function move()
{
	_x = _root._xmouse;
}
function checkCollision()
{
	if (hitTest("_root.classicBall0"))
		{
		_root.sndRobotHit.start();
		_root.classicBall0.outs += 1;
		
		_root.classicBall0.freeze = 1;
		//_root.classicBall0.dx = 0;
		_root.classicBall0.dx = ((Math.random()*1.5)-.75);
 		_root.classicBall0.dy = _root.classicBall0.ballSpeedy;
		_root.textBox._y = 445;
		
		_root.textBox.info = ("out " + _root.classicBall0.outs + " !");
			
		_root.textBox.gotoAndPlay(1);
		
		
		//this.removeMovieClip();
		}
		
		
	
}

}

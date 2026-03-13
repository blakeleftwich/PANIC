class BrickDestroy extends MovieClip
{

var i: Number;

var collisionOff: Number;

var ballNumber;

//var dy: Number;

function BrickDestroy()
{

//will never have more than 5 balls
collisionOff = 0;
ballNumber=1;
_x = 20;
_y = 40;
//dy = .1;
}

	function onEnterFrame()
	{
	animate();
	}

	function animate()
	{
 	gotoAndPlay(1);
	}



}

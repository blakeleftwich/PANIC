class BrickBall extends MovieClip
{

var i: Number;

var row;
var col;

var ballNumber;

function BrickBall()
{
//will never have more than 5 balls
ballNumber=5;
_x = 120;
_y = 140;
row = 2;
col = 3;
}

function onEnterFrame()
{
	checkBallCollision();
}

function checkBallCollision()
{
	//this loop checks for collision for every ball
	//it works no matter how many balls are on the screen 
	//as long as there are no more than the ballNumber
	for (i = 0; i <ballNumber; i++)
	{
   				
		if (hitTest("_root.ball" + i))
		{
		_root.attachMovie("ball", "ball_" + row + "_" + col, (row * 70) + (col * 70));
      _root.ball = eval("ball_" + row + "_" + col);
      _root.ball._x = _x;
      _root.ball._y = _y;
		//destroy this brickBall		
		this.removeMovieClip();
		}
		
	}
}

}

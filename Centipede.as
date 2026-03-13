class Centipede extends MovieClip
{

var dx: Number;
var dy: Number;

var i: Number;

var ballNumber;

function Centipede()
{
//speed moving left to right
dx = 1;
dy = 0;
//will never have more than 5 balls
ballNumber=5;
}

function onEnterFrame()
{
	move();
	checkBoundries();
	checkBallCollision();
	
}

function move()
{
	_x += dx;
	_y += dy;
}
function checkBoundries()
{
	if (_x > Stage.width -(_width/2))
	{
	for (i = 0; i < 40; i++)
		{_y += 1;	}
	dx = -dx;
	}
	
	if (_x < _width/2)
		{
		for (i = 0; i < 40; i++)
		{_y += 1;	}
		dx = -dx;
		}
	
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
		//destroy this Centipede		
		this.removeMovieClip();
		}
		
	}
}

}

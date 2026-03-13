class Sticky extends MovieClip
{

var dx: Number;
var dy: Number;

var row: Number;
var col: Number;

var i: Number;

var ballNumber;

function Sticky()
{
//speed moving left to right
dx = 4;
dy = .2;
//will never have more than 5 balls
ballNumber=5;
}

function onEnterFrame()
{
	move();
	checkBoundries();
	checkBrickCollision();
	checkBallCollision();
	checkBomb();
}

function move()
{
	_x += dx;
	_y += dy;
	
	//_root.attachMovie("bomb", "bomb0", 2000);
      //_root.bomb = eval(_root.bomb0);
      //_root.bomb._x = _root.sticky_1_7._x;
	  //_root.bomb._y = _root.sticky_1_7._y + dy;
}

function checkBoundries()
{
	if (_x > Stage.width -(_width/2) - 74)
	{
	for (i = 0; i < 40; i++)
		{_y += 1;	}
	dx = -dx;
	}
	
	if (_x < (_width/2) + 75)
		{
		for (i = 0; i < 40; i++)
		{_y += 1;	}
		dx = -dx;
		}
	
}

function checkBrickCollision()
{
	for (row = 1; row <= 3; row++)
	{
		for (col = 1; col <= 11; col++)
		{
			if (hitTest("_root.brick_" + row + "_" + col))
				{
				for (i = 0; i < 2; i++)
					{_y -= 1;	
					
					}
				}
		}
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
		//destroy this sticky		
		this.removeMovieClip();
		}
		
	}
}

	function checkBomb()
	{
		if(_x> Stage.width/2)
		{
			if(Math.ceil(Math.random()*6) > 2)
				{
				_root.stickysBomb();
				_root.nextBomb +=1;
				}
		}
	}
}

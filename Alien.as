class Alien extends MovieClip
{

var dx: Number;
var dy: Number;

var row: Number;
var col: Number;

var i: Number;

var ballNumber;

var falling: Number;
var hitPoints: Number;

function Alien()
{
//speed moving left to right
dx = 2;
dy = 0;
//will never have more than 5 balls
ballNumber=5;
_x=200;
_y=210;
falling = 0;
hitPoints = 8;
}

function onEnterFrame()
{
	move();
	checkBoundries();
	//checkBrickCollision();
	checkBallCollision();
	//checkBomb();
}

function move()
{
	
	
	_x += dx;
	_y += dy;
	
	if(falling == 0)
	{
		dy += .002*Math.sin(dx);
		if (_y > 260)
		{
			dx += .5
			dy = -dy;
		}
		if (_y < 210)
		{
			dx -= .5
			dy = -dy;
		}
	}
	else
	{
		dy += .3;
	}
	//dx+=.01;
	//if(dx>2)
	//{dx=.1}
	//if(dx<-2)
	//{dx=-.1}
}

function checkBoundries()
{
	if (_x > Stage.width -(_width/2) - 65)
	{
	//_y += 40;	
		
	dx = -dx;
	}
	
	if (_x < (_width/2) + 89)
		{
		//_y += 40;	
		
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
		
		_root.backGround.gotoAndPlay(2);
			
			if(_root.ball0._x > _x)//if ball hits right side of brick
				{
					if(_root.ball0.dx < 0 && _root.ball0._y > _y - 34 && _root.ball0._y < _y + 67)//if ball is moving left and in an accuracy box on the right side then bounce left
					{
						if(_root.ball0.dx < 0)
						{
						//hitPoints -= 1;
						if (falling == 0)
							{
							_root.bank += 30;
							_root.bankBar = (_root.bank + " x " + _root.multiplier);
							}
						//_root.ball0.dx = -_root.ball0.dx;
						}
					}
				}
				if(_root.ball0._x < _x)//if ball hits left side of brick
				{
					if(_root.ball0.dx > 0 && _root.ball0._y > _y - 34 && _root.ball0._y < _y + 67)//if ball is moving right and in an accuracy box on the left side then bounce right
					{
						if(_root.ball0.dx > 0)
						{
						//hitPoints -= 1;
						if (falling == 0)
		{
		_root.bank += 30;
		_root.bankBar = (_root.bank + " x " + _root.multiplier);
		}
						//_root.ball0.dx = -_root.ball0.dx;
						}
						//dx = -3;
					}
					
				}
				
      			if(_root.ball0._y > _y + 44)
				{
					if (_root.ball0.dy < 0)
					{
						//hitPoints -= 1;
						if (falling == 0)
						{
							_root.bank += 30;
							_root.bankBar = (_root.bank + " x " + _root.multiplier);
						}
						//_root.ball0.dy = -_root.ball0.dy;
					}
					
				}
				
      			if(_root.ball0._y < _y + 44)
				{
					if (_root.ball0.dy > 0)
					{
						//hitPoints -= 1;
						if (falling == 0)
		{
		_root.bank += 30;
		_root.bankBar = (_root.bank + " x " + _root.multiplier);
		}
						//_root.ball0.dy = -_root.ball0.dy;
					}
					
				}
		
		//_root.brickCount-=1;
		
		
		//gotoAndPlay(1);
		//dy = -.2;
		//if (hitPoints < 0)
		//{
		//dy = -.3
		//_root.bank += 200;
		if (falling == 0)
		{
		_root.bank += 30;
		_root.bankBar = (_root.multiplier + " x " + _root.bank);
		}
		_root.sndRobotBlow.stop("robotBlow");
		_root.sndRobotBlow.start();
		gotoAndStop(3);
		this.removeMovieClip();
		falling = 1;
		//}
		//destroy this alien		
		//this.removeMovieClip();
		}
		
	}
}

	
}

class Robot extends MovieClip
{
var bombDrop: Number;
var bombX: Number;

var hitPoints: Number;

var pass: Number;
	
var upperBombRange: Number;
var lowerBombRange: Number;
	
var dx: Number;
var dy: Number;

var row: Number;
var col: Number;

var i: Number;

var ballNumber;

function Robot()
{
//speed moving left to right
dx = (2+(_root.difficulty));
dy = 0;
//will never have more than 5 balls
ballNumber=5;

//bombDrop=20;

pass=0;

hitPoints = 2+_root.difficulty;

row=1;
col=1;

upperBombRange=110;
lowerBombRange=90;

bombX=0;
}

function onEnterFrame()
{
	move();
	checkMakeNewBricks();
	checkBoundries();
	//checkBrickCollision();
	
	checkBallCollision();
	//checkBomb();
}

function move()
{
	pass+=1;
	//bombDrop += 5;
	
	_x += dx;
	_y += dy;
	
	if (bombX == 1)
	{
		
			dx+=.04
		
		//_y -= 1;
		
		if (dx < (2 + _root.difficulty))
		{
			//gotoAndPlay(12);
			bombX = 0;
		}
	}
	
	
	//if (hitPoints > 1)
	//{
		//_root.wave = 6;
	//}
	//else
	//{
		//_root.wave += 1;
	//}
	//for (row = 1; row <= 3; row++)
	//{
		//for (col = 1; col <= 11; col++)
		//{
			//if (!hitTest("_root.brick_" + row + "_" + col))
				//{
				//if(("_root.brick_"+ row + "_" + col + "_x")< _x)
					//{
						//dx = -4;
					//}
					
				//}
		//}
	//}

	//_root.attachMovie("bomb", "bomb0", 2);
      //_root.bomb = eval(_root.bomb0);
      //_root.bomb._x = _root.robot_1_1._x;
	  //_root.bomb._y = _root.robot_1_1._y + dy;
	
}

function checkBoundries()
{
	if (_x > Stage.width - 140)
	{
	//for (i = 0; i < 40; i++)
		//{_y += 1;	}
	dx = -dx;
	//bombX = -bombX;
	//pass+=1;
	}
	
	if (_x < 140)
		{
		//for (i = 0; i < 40; i++)
		//{_y += 1;	}
		dx = -dx;
		//bombX = -bombX;
		pass+=1;
		}
	
}

function checkBrickCollision()
{
	for (row = 1; row <= 5; row++)
	{
		for (col = 1; col <= 11; col++)
		{
			if (hitTest("_root.brick_" + row + "_" + col))
				{
				
				//_root.brickCount -=1;
				//for (i = 0; i < 2; i++)
					//{_y -= 1;	
					
					
					//}
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
		//destroy this robot		
		if (hitPoints < 1)
		{
		//_root.wave += 1
			//_root.brickCount = 0;
			//_root.sndTwerpBounce.stop("twerpBounce");
		//_root.sndTwerpBounce.start();
			_root.ball0.dx = -_root.ball0.dx;
			_root.sndRobotLaugh.stop("robotLaugh");
			_root.sndRobotBlow.start();
			this.removeMovieClip();
		}
		else
		{
			
			if(_root.ball0.dx > 0)
			{
				_root.ball0._x -= 8;
				_root.ball0.dx+=.2
			}
			if(_root.ball0.dx < 0)
			{
				_root.ball0._x += 8;
				_root.ball0.dx+=.2
			}
			
			_root.ball0.dx = -_root.ball0.dx;
			
			if (_root.ball0._y < _y + 84 && _root.ball0._x > _x-12 && _root.ball0._x < _x+12)
			{
			_root.ball0._y = _y + 85;
			_root.ball0.dy = -_root.ball0.dy;
			}
			
			//_root.ball0.dx = -_root.ball0.dx;
				if (dx > 0)
				{
				dx -= .2;
				gotoAndPlay(1);
				bombX = 1;
				}
				if (dx < 0)
				{
				dx += .2;
				gotoAndPlay(1);//
				bombX = 1;
				}
			//_y-=1;
			
			_root.bank += 200;
			_root.bankBar = (_root.multiplier + " x " + _root.bank);
			_root.sndTwerpBounce.stop("twerpBounce");
			_root.sndTwerpBounce.start();
			hitPoints -= 1;
		}
		}
		
	}
}

	
	
	function checkMakeNewBricks()
	{
		if (_root.brickCount < 20 )//was 20
		{
			//_root.sndZap.stop("robotHit");
			_root.sndRobotHit.start();
			_root.brickCount = 27;
			_root.createBricks(3,9,60.5,200);//(endRow,endCol,startBrickX,startBrickY)
		}
	}
	
}



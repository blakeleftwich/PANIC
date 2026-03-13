class Twerp extends MovieClip
{
var num1: Number;
var num2: Number;
	
var hold: Number;	
	
var hitPoints: Number;	
	
var wallBounce: Number;
var gravityIncrement: Number;
	
var dx: Number;
var dy: Number;
var gravity: Number;
var gravitySwitch: Number;

var row: Number;
var col: Number;

var i: Number;

var ballNumber;

function Twerp()
{
if (_root.difficulty == 0)
{
	wallBounce = 15;
	hitPoints = 1;	
	gravityIncrement = .01;
}
if (_root.difficulty == 1)
{
	wallBounce = 18;
	hitPoints = 3;	//original 1
	gravityIncrement = .025;
}
if (_root.difficulty == 2)
{
	wallBounce = 21;
	hitPoints = 3;	
	gravityIncrement = .023;
}

	
gravity = 0;
gravitySwitch = 1;
//speed moving left to right
dx = (1+_root.difficulty);
dy = 0;//.2
//will never have more than 5 balls
ballNumber=5;
hold = 0;
}

function onEnterFrame()
{
	
	
	move();
	checkBoundries();
	checkPaddleCollision();
	checkBrickCollision();
	checkBallCollision();
	checkClassicBallCollision();
	checkDestroyed();
		if(hold ==1)
		{
			checkHolding();
		}
	//checkBomb();
}

function move()
{
	
	
	_x += dx;
	_y += dy;
	
	//if(gravitySwitch == 1)
		//{
			dy+=gravity;
			gravity+=gravityIncrement;//.006//.01
					
			//controls top speed of fall
			//watch out for getting caught
			//between bricks (if number is too low)
			if (gravity > (.1+(_root.difficulty*.1)))
			{gravity = (.1+(_root.difficulty*.1));}
			
			//if (gravity < -1)
			//{gravity = -1;}
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
     // _root.bomb = eval(_root.bomb0);
     // _root.bomb._x = _root.twerp_1_1._x;
	  //_root.bomb._y = _root.twerp_1_1._y + dy;
}

function checkBoundries()
{
	if (_x > Stage.width -(_width/2) - 74)
	{
	//for (i = 0; i < 40; i++)
		//{_y += 1;	}
	gotoAndPlay(13);
	dx = -dx;
	}
	
	if (_x < (_width/2) + 75)
		{
		//for (i = 0; i < 40; i++)
		//{_y += 1;	}
		gotoAndPlay(1);
		dx = -dx;
		}
		
		if(_y>700)
		{
			//_y = 90;
			//gravity=0;
			//dy=0;
			this.removeMovieClip();
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
				//for (i = 0; i < 2; i++)
					//{//_y -= 1;	
					
					//testing to track specific coordinates of each brick
				num1 = eval("_root.brick_" + row + "_" + col + "._x");
				num2 = eval("_root.brick_" + row + "_" + col + "._y");
      			if(_x > num1 && _y + 15.1 > num2 - 7.5)//if ball hits right side of brick
				{
					if(dx < 0 && _y > num2 - wallBounce && _y < num2 + wallBounce)//8.4//if ball is moving left and in an accuracy box on the right side then bounce left
					{
						if(dx < 0)
						{
						gotoAndPlay(1);
						dx = -dx;
						//_y += 1;
						}
					}
				}
				if(_x < num1 && _y + 15.1 > num2 - 7.5 )//if ball hits left side of brick
				{
					if(dx > 0 && _y > num2 - wallBounce && _y < num2 + wallBounce)//if ball is moving right and in an accuracy box on the left side then bounce right
					{
						if(dx > 0)
						{
						gotoAndPlay(13);
						dx = -dx;
						//_y += 1;
						}
						//dx = -3;
					}
					
				}
					//num2 = eval("_root.brick_" + row + "_" + col + "._y");
      			//if(_y  < num2)
				//{
					//if (dy > 0)
					//{
						//gravity = .006;
						//dy = -gravity;
						//dy = -dy;
					//}
					
				//}
				if (_y + 15.1 > num2 - 7.5 && _x > num1 - 1 && _x < num1 + 1)
					{gravity = gravityIncrement;}//.01
					
					
					dy = -gravity;
					//gravity -= .006;
					//gravitySwitch = 0;
					
					}
					else
					{
						
						dy += .004;
					}
				//}
				//else
				//{gravitySwitch = 1;}
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
			hold = 1;
			
			_root.ball0.dx = _root.ball0.ballSpeedx;
			_root.ball0.dy = _root.ball0.ballSpeedy;
			//trace("aiming = 1");
			//this.removeMovieClip();
		}
		//{
		//destroy this twerp		
		//}
		//if(_root.ball0._dy > 0)
		//{
			//dy+=_root.ball0._dy;
		//}
		//if(hitPoints < 1)
		//{
			//_root.bank+=1000;
			//this.removeMovieClip();
			//gotoAndPlay(25);
		//}
		//else
		//{
			//hitPoints-=1;
		//}
		//_root.brickCount = 0;
		//}
		
	}
	   				
		//testing collision with paddle-if so-destroy each other
		
		
	
}

function checkPaddleCollision()
{
	
	if (hitTest("_root.paddle"))
		{
			//if (_root.ball0.aiming ==1)
			//{
				//gotoAndPlay(25);
				//this.removeMovieClip();
			//}
		dy = -10;
		_root.sndTwerpBounce.stop("twerpBounce");
		_root.sndTwerpBounce.start();
		hitPoints -= 1;
		//_root.multiplier+=1;
		_root.bank+=50;
		_root.bankBar = (_root.multiplier + " x " + _root.bank);
		//_root.bankBar = (_root.multiplier + " x " + _root.bank);
		//destroy this twerp		
		//_root.paddle.removeMovieClip();
		gotoAndPlay(49);//49
		}
		//else
		//{
			//this.removeMovieClip();
		//}
	//if (_root.ball0._y > _root.paddle._y)
	//{
		//this.removeMovieClip();
	//}
}

function checkClassicBallCollision()
{
	//this loop checks for collision for every ball
	//it works no matter how many balls are on the screen 
	//as long as there are no more than the ballNumber
	for (i = 0; i <ballNumber; i++)
	{
   				
		if (hitTest("_root.classicBall" + i))
		
		{
		
		if (hitPoints < 1)
		{
		_root.bank+=50;
		_root.bankBar = (_root.multiplier + " x " + _root.bank);
		gotoAndPlay(25);
		}
		else
		{
			hitPoints-=1;
		}
		//destroy this twerp		
		//this.removeMovieClip();
		}
		
	}
}

	function checkDestroyed()
	{
		if (hitPoints < 0)
		{
			if (hold == 1)
			{_root.ball0.dy = -_root.ball0.launchSpeed;}
			
			hold = 0;
			hitPoints = 3;
			
			_root.bank+=200;
			_root.bankBar = (_root.multiplier + " x " + _root.bank);
			_root.sndTwerpSound.stop("twerpSound");
			_root.sndRobotBlow.start();
			this.removeMovieClip();
		}
	}
	function checkHolding()
	{
		
			_root.ball0._y = _y - 7;
			_root.ball0._x = _x - 3.5;
		
	}
}

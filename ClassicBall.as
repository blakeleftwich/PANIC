class ClassicBall extends MovieClip
{
var num1: Number;
var num2: Number;
	
var freeze: Number;
var count: Number;	

var outs: Number;
var runs: Number;

var baseHits: Number;
var fouls: Number;
var strikes: Number;
	
var aiming: Number;	
var aimX: Number;	
var ax: Number;	
	
var dx: Number;
var dy: Number;

var ballSpeedx: Number;
var ballSpeedy: Number;
var launchRate: Number;

var relX: Number;
var newDx: Number;
var relPerc: Number;


static var ballEndRow: Number;
static var ballEndCol: Number;

//need to find a way to make row and col numbers customizable
//they need to correspond to any row or col number set in game
var row: Number;
var col: Number;

var classicBallControl: Number;

function ClassicBall()
{
if (_root.difficulty ==0)
{
ballSpeedx = 2;
ballSpeedy = 5;//8
launchRate = 3;
}
if (_root.difficulty ==1)
{
ballSpeedx = 2.5;
ballSpeedy = 6.5;//8
launchRate = 3.5;
}
if (_root.difficulty ==2)
{
ballSpeedx = 3;
ballSpeedy = 8;//8//-6
launchRate = 4;
}

freeze = 0;
//_x = _root.paddle._x;
//_y = _root.paddle._y;
aimX = 0;
ax = launchRate;

//starting verticle classicBall speed and direction

classicBallControl = 12;//default 10 for great control
row=1;
col=7;

outs = 0;
runs = 0;
baseHits = 0;
fouls = 0;
strikes = 0;

count = 0;

if(_root.baseballWave == 0)
{aiming = 1;
 dx = 3;
 dy = -6;}
else
{aiming = 0;
 dx = 0;
 dy = ballSpeedy;
 _x = Stage.width/2;
 _y = Stage.height/2 + 30;}
}

function onEnterFrame()
{
	move();
	checkBoundries();
	checkInvaderCollision();
	checkPaddleCollision();
	checkBrickCollision();
	if(_root.baseballWave == 1)
	{
		checkBallLocation();
		timer();
		checkRuns();
	}
	
}

function move()
{
	
	if (aiming == 0)
	{
		if (freeze == 0)
		{
			_x += dx;
			_y += dy;
		}
		else if (freeze == 1)
		{
			_x = Stage.width/2;
 			_y = Stage.height/2 + 30;
		}
		
		//gravity
		//dy += .2;
		
		//if(_root.wave > 39)
		//{
			//if(_root.brickCount < 12)
			//{
				//if (dy > 0)
				//{
					//dy = (ballSpeedy+2);
				//}
				
				///if (dy < 0)
				//{
					//dy = -(ballSpeedy+2);
				///}
			//}
		//}
		
	}
	else
	{
		//aiming movement
		//classicBall goes back and forth over the paddle
		_x = _root.paddle._x + aimX;
		
		aimX += ax;
		
		if ( _x > _root.paddle._x + 30)
		{ax = -launchRate;}
		
		
		if ( _x < _root.paddle._x - 30)
		{ax = launchRate;}
		
		//classicBall floats right over paddle
		_y = _root.paddle._y - 18;
	}
}
function checkBoundries()
{
	//if classicBall hits left or right side bounce in opposite direction
	if (_x > Stage.width - (_width/2) - 75)
	{
		_root.sndBlip.stop("blip");
		_root.sndBlip.start();
		_x = Stage.width - (_width/2) - 75;
		dx = -dx;
	}
	if (_x < _width/2 + 75)
	{
	 	_root.sndBlip.stop("blip");
		_root.sndBlip.start();
		_x = _width/2 + 75;
		dx = -dx;
	}
	//if classicBall hits top or bottom of stage bounce in opposite direction
	if (_y < _height/2 + 75)
	{
		_root.sndBlip.stop("blip");
		_root.sndBlip.start();
		_y = _height/2 + 75;
		dy = -dy;
	}
	//quick off bottom of screen fix
	if (_y > Stage.height)
	{
		if(_root.wave > 39 && _root.wave != 60 && _root.wave != 78)
		{
		_root.sndOffScreen.stop("offScreen")
		_root.sndOffScreen.start();
		
		//take away a life
			_root.lives-=1;
			//draw lives
			_root.drawLives();
			
			//check to see if no more lives
			if (_root.lives < 0)
			{
				
				//if no more lives goto title screen
				_root.gotoAndStop("title");
				//kill myself
				this.removeMovieClip();
			}
		
		}
		//_y = Stage.height-120;
		//dy = -dy;
		//_root.score += _root.bank;
		//_root.bank = 0;
		//_root.multiplier = 0;
		//_root.bankBar = (_root.multiplier + " x " + _root.bank);
		if(_root.baseballWave == 1)
		{
			freeze = 1;
			//dx = 0;
			_root.classicBall0.dx = ((Math.random()*1.5)-.75);
			//dx = Math.ceil((Math.random()*6)-3);
 			dy = ballSpeedy;
			
			strikes += 1;
			_root.sndRobotHit.start();
			_root.textBox._y = 445;
			_root.textBox.info = ("strike " + strikes + " !");
			_root.textBox.gotoAndPlay(1);
		}
		else
		{
			aiming = 1;
		}
	}
	
}

function checkInvaderCollision()
{
	//loop checks collision on every invader-row and col are the same as in the
	//invader creation loop in the main (root) code	
	//NEED TO GET THESE NUMBERS FROM ROOT SO IT NEVER CHECKS FOR IMPOSSIBLE
	//COLLISIONS THAT EAT PROCESS TIME!!!!
	for (row = 1; row <= 1; row++)
	{
   		 for (col = 1; col <= 8; col++)
		{	
			if (hitTest("_root.twerp_" + row + "_" + col))
			{
				//increases speed of classicBall with each bounce
				//if (dy > 0)
				//{
					//dy += .5;
					//trace ("down is working");
				//}
				//else
				//{
					//dy -= .5;
					//trace ("up is working")
				//}
			//_root.multiplier += 1;
			_root.score += 100;
			//_root.bankBar = (_root.multiplier + " x " + _root.bank);
			//dy += 2;//this makes classicBall speed up when hitting invaders
			dy = -dy; //bounce in opposite (y) direction
				
			}
		}
	}
}
function checkBrickCollision()
{
	
	//countBricks!
		if (_root.brickCount <= 0)
			{
				_root.wave += 1;
				//trace("wave = " + _root.wave);
				_root.brickCount = 18;
				_root.placeBricks(_root.wave);
				//trace ("next stage working")
			}
	
	//loop checks collision on every invader-row and col are the same as in the
	//invader creation loop in the main (root) code	
	for (row = 1; row <= ballEndRow; row++)
	{
   		 for (col = 1; col <= ballEndCol; col++)
		{	
			if (hitTest("_root.brick_" + row + "_" + col))
			{
				
				_root.sndWall.stop("brickBreak")
				_root.sndWall.start();
				//testing to track specific coordinates of each brick
				num1 = eval("_root.brick_" + row + "_" + col + "._x");
				num2 = eval("_root.brick_" + row + "_" + col + "._y");
      			if(_x > num1)//if classicBall hits right side of brick
				{
					if(dx < 0 && _y > num2 - 8 && _y < num2 + 8)//if classicBall is moving left and in an accuracy box on the right side then bounce left
					{
						if(dx < 0)
						{
						dx = -dx;
						}
					}
				}
				if(_x < num1 )//if classicBall hits left side of brick
				{
					if(dx > 0 && _y > num2 - 8 && _y < num2 + 8)//if classicBall is moving right and in an accuracy box on the left side then bounce right
					{
						if(dx > 0)
						{
						dx = -dx;
						}
					}
						
					
				}
				
      			if(_y  > num2)
				{
					if (dy < 0)
					{
						dy = -dy;
					}
					
				}
				num2 = eval("_root.brick_" + row + "_" + col + "._y");
      			if(_y  < num2)
				{
					if (dy > 0)
					{
						dy = -dy;
					}
					
				}
				
			_root.score += 10;
						
			//_root.brickCount -=1;
			}
		}
	}
}
function checkPaddleCollision()
{
	//if classicBall hits left or right side bounce in opposite direction
	if (hitTest(_root.paddle))
	{
		if (_x + 1 >_root.paddle._x - (_root.paddle._width/2) && _x - 1 < _root.paddle._x + (_root.paddle._width/2))
		{
		_y = (_root.paddle._y - (_root.paddle._height/2) -(_height/2));
		_root.sndPaddlePong.stop("paddlePong");
		_root.sndPaddlePong.start();
		dy = -dy;
		}
		else
		{
			_root.sndPaddlePong.stop("paddlePong");
			_root.sndPaddlePong.start();
			dy = -dy;
		}
		dx = getDx(_root.paddle);
	}
}




//find exactly where the classicBall hit the paddle
function getDx(paddle)
{
relX = _x - _root.paddle._x;
relPerc = relX/_root.paddle._width;
newDx = relPerc * classicBallControl;
return newDx;
}

///function getBrickDx(brick)
//{
//relX = _x - ("_root.brick_" + row + "_" + col + "._x");
//relPerc = relX/("_root.brick_" + row + "_" + col + "._width");
//newDx = relPerc * classicBallControl;
//return newDx;
//}


function onMouseDown()
{
	//as long as you are not aiming cash in points
	//and reset y speed to 0;
	//if (aiming == 0)
		//{
		//_root.score += _root.multiplier*_root.bank;
		//_root.bank = 0;
		//_root.multiplier = 0;
		//_root.bankBar = (_root.multiplier + " x " + _root.bank);
		
		//reset the classicBall y speed to 0
		//dy = 0;
		//}
	
	if (_root.tallyPanel.panelState == 1)
		{
		_root.tallyPanel.panelState = 2;
		_root.tallyText.gotoAndPlay(61);
		//freeze = 1;
		}
	
	//if you are aiming the classicBall and you click the button
	//do not cash in points and reset classicBall speed
	//instead launch classicBall at a speed of 10 in a direction
	//according to the classicBall's position over the paddle
	if (aiming == 1)
		{
		dx = getDx(_root.paddle);
		//first shot speed default is -8
		dy = ballSpeedy;
		aiming = 0;
		}
	
	
}

function checkBallLocation()
{
	if(_x < 90 || _x > 460)
	{
		if (_y > 330 && aiming == 0)
		{
			freeze = 1;
			//dx = 0;
			_root.classicBall0.dx = ((Math.random()*1.5)-.75);
			//_root.classicBall0.dx = Math.ceil((Math.random()*6)-3);
 			dy = ballSpeedy;
			
			fouls += 1;
			_root.sndRobotHit.start();
			_root.textBox._y = 445;
			_root.textBox.info = ("foul !");
			_root.textBox.gotoAndPlay(1);
		}
		else if (_y > 160 && aiming == 0)
		{
			
			
			freeze = 1;
			//dx = 0;
			_root.classicBall0.dx = ((Math.random()*1.5)-.75);
			dy = ballSpeedy;
			
			baseHits+=1;
						_root.sndCrowd.stop ("crowd");
  				_root.sndCrowd.start(0,2);
			_root.textBox._y = 445;
			_root.textBox.info = ("base hit !");
			_root.textBox.gotoAndPlay(1);
		}
		else if (aiming == 0)
		{
			
			
			freeze = 1;
			//dx = 0;
			_root.classicBall0.dx = ((Math.random()*1.5)-.75);
			//_root.classicBall0.dx = Math.ceil((Math.random()*6)-3);
 			dy = ballSpeedy;
			
			runs+=1;
						
			_root.textBox._y = 445;
			if(baseHits > 0)
			{
				if(baseHits < 3)
				{
					_root.textBox.info = ((baseHits + 1) + " runs !");
					_root.textBox.gotoAndPlay(1);
					
					_root.bonus += (100 * (baseHits + 1));
					_root.bankBar = ("bonus " + _root.bonus);
					baseHits = 0;
				}
				else
				{
					_root.sndCrowd.stop ("crowd");
  				_root.sndCrowd.start(0,5);
					_root.textBox._y = 331.8;
					_root.textBox.info = ("grand slam !");
					_root.textBox.gotoAndPlay(1);
					
					_root.bonus += 700;
					_root.bankBar = ("bonus " + _root.bonus);
					baseHits = 0;
				}
			}
			else
			{
				
				_root.sndCrowd.stop ("crowd");
  				_root.sndCrowd.start(0,3);
				_root.textBox.info = ("homer !");
				_root.textBox.gotoAndPlay(1);
				
				_root.bonus += 300;
				_root.bankBar = ("bonus " + _root.bonus);
				baseHits = 0;
			}
		}
	}
	if (_y < 90)
		{
			freeze = 1;
			//dx = 0;
			_root.classicBall0.dx = ((Math.random()*1.5)-.75);
 			dy = ballSpeedy;
			
			runs+=1;
			
			_root.textBox._y = 445;
			if(baseHits > 0)
			{
				if(baseHits = 3)
				{
					_root.sndCrowd.stop ("crowd");
  				_root.sndCrowd.start(0,5);
					_root.textBox._y = 331.8;
					_root.textBox.info = ("grand slam !");
					_root.textBox.gotoAndPlay(1);
					
					_root.bonus += 700;
					_root.bankBar = ("bonus " + _root.bonus);
					
					baseHits = 0;
				}
				else
				{
					_root.textBox.info = ((baseHits + 1) + " runs !");
					_root.textBox.gotoAndPlay(1);
					
					_root.bonus += (100 * (baseHits + 1));
					_root.bankBar = ("bonus " + _root.bonus);
					
					baseHits = 0;
				}
			}
			else
			{
				_root.sndCrowd.stop ("crowd");
  				_root.sndCrowd.start(0,3);
				_root.textBox.info = ("homer !");
				_root.textBox.gotoAndPlay(1);
				
				_root.bonus += 300;
				_root.bankBar = ("bonus " + _root.bonus);
				
				
				baseHits = 0;
			}
			
		}
		
}

function timer()
{
	if (count < 200 && freeze == 1)
	{
		count++;
		//trace("counting");
	}
	else
	{
		freeze = 0;
		count = 0;
	}
}

function checkRuns()
{
	if (outs > 2)
	{
		_root.textBox.info = (" ");
		_root.brickCount = 0;
	}
	
	if (fouls > 3)
	{
		outs += 1;
		_root.textBox._y = 445;
		_root.textBox.info = ("out " + outs + " !");
			if (outs < 3)
			{
				_root.textBox.gotoAndPlay(1);
			}
		fouls = 0;
	}
	
	if (strikes > 2)
	{
		outs += 1;
		_root.textBox._y = 445;
		_root.textBox.info = ("out " + outs + " !");
		if (outs < 3)
			{
			_root.textBox.gotoAndPlay(1);
			}
		strikes = 0;
	}
	
	if (baseHits > 3)
	{
		runs += 1;
		_root.textBox._y = 445;
		_root.textBox.info = ("run in !");
		_root.textBox.gotoAndPlay(1);
		
		_root.bonus += 100;
		_root.bankBar = ("bonus " + _root.bonus);
		
		baseHits = 3;
	}
		
}

}

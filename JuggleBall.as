class JuggleBall extends MovieClip
{
var num1: Number;
var num2: Number;
	
var brick: String;	

var canScore: Number;
	
var ball2Switch: Number;	
var ball3Switch: Number;
	
var freeze: Number;	
var storeBank: Number;	
	
var i:Number;
var z:Number;

var juggleJuggleBallSlow: Number;
var juggleJuggleBallSpeedx: Number;
var juggleJuggleBallSpeedy: Number;
var juggleJuggleBallGravity: Number;
var launchSpeed: Number;
var launchRate: Number;
var bounceIncrease: Number;
var bounceIncreaseEnemy: Number;
	
var aiming: Number;	
var aimX: Number;	
var ax: Number;	
	
var dx: Number;
var dy: Number;

var relX: Number;
var newDx: Number;
var relPerc: Number;

static var juggleJuggleBallEndRow: Number;
static var juggleJuggleBallEndCol: Number;
//need to find a way to make row and col numbers customizable
//they need to correspond to any row or col number set in game
var row: Number;
var col: Number;

var juggleJuggleBallControl: Number;

function JuggleBall()
{
//adjusting for slower framerate
//originally 60fps-adjusting
//for 15fps-optimize later

  if (_root.difficulty ==2)
{
juggleJuggleBallSlow = 100;
juggleJuggleBallSpeedx = 2;
juggleJuggleBallSpeedy = 6;
juggleJuggleBallGravity = .05;
launchSpeed = 9;
launchRate = 4;
bounceIncrease = .7;
bounceIncreaseEnemy = 0;//.2
}
if (_root.difficulty ==1)
{
juggleJuggleBallSlow = 80;
juggleJuggleBallSpeedx = 2.5;
juggleJuggleBallSpeedy = 7;
juggleJuggleBallGravity = .1;
launchSpeed = 10;
launchRate = 3.5;
bounceIncrease = .6;
bounceIncreaseEnemy = .5;
}
if (_root.difficulty == 0)
{

juggleJuggleBallSlow = 60;	
juggleJuggleBallSpeedx = 3;
juggleJuggleBallSpeedy = 8;
juggleJuggleBallGravity = .2;
launchSpeed = 11.3;
launchRate = 3;
bounceIncrease = .5;
bounceIncreaseEnemy = 1;

//60fps
//juggleJuggleBallSlow = 60;	
//juggleJuggleBallSpeedx = 3;
//juggleJuggleBallSpeedy = 8;
//juggleJuggleBallGravity = .2;
//launchSpeed = 11.3;
//launchRate = 4;
//bounceIncrease = .5;
//bounceIncreaseEnemy = 1;
}
_y = 300;

i=0;
freeze = 0;
storeBank = 0;
//_x = _root.paddle._x;
//_y = _root.paddle._y;
aimX = 0;
ax = launchRate;//ax = 4;
dx = juggleJuggleBallSpeedx;
//starting verticle juggleJuggleBall speed and direction
dy = -juggleJuggleBallSpeedy;//default -8
juggleJuggleBallControl = 10;
row=1;
col=7;
aiming = 1;

ball2Switch = 0;
ball3Switch = 0;

canScore = 0;

//juggleJuggleBallEndRow = 6;//6
//juggleJuggleBallEndCol = 9;//9
}

function onEnterFrame()
{
	if(freeze == 0)//if freeze ==1 then don't move
	{
	move();
	
	checkBoundries();
	checkPaddleCollision();
	//checkBrickCollision();
	
	
	}//end if freeze
}

function move()
{
	
	if (aiming == 0)
	{
		
		_x += dx;
		_y += dy;
		
		//gravity
		dy += .2//juggleJuggleBallGravity;//default .2
		if (dy > juggleJuggleBallSpeedy + 4)
		{
			dy = juggleJuggleBallSpeedy + 4
		}
		//dy += .05;
	}
	else
	{
		//aiming movement
		//juggleJuggleBall goes back and forth over the paddle
		_x = _root.paddle._x + aimX;
		
		aimX += ax;
		
		if ( _x > _root.paddle._x + 30)
		{ax = -launchRate;}
		
		
		if ( _x < _root.paddle._x - 30)
		{ax = launchRate;}
		
		//juggleJuggleBall floats right over paddle
		_y = _root.paddle._y - 18;
	}
	
}
function checkBoundries()
{
	//if juggleJuggleBall hits left or right side bounce in opposite direction
	if (_x > Stage.width - (_width/2) - 75)
	{
		//sound effect
		
		_root.sndPaddleBounce.stop("paddleBounce");
		_root.sndPaddleBounce.start();
	
		_x = Stage.width - (_width/2) - 75;
		dx = -dx;
	}
	if (_x < _width/2 + 75)
	{
	 	//sound effect
		//_root.sndBlip.stop();
		_root.sndPaddleBounce.stop("paddleBounce");
		_root.sndPaddleBounce.start();
		
		_x = _width/2 + 75;
		dx = -dx;
	}
	//if juggleJuggleBall hits top or bottom of stage bounce in opposite direction
	if (_y < _height/2 + 75)
	{
		//sound effect
		//_root.sndBlip.stop();
		_root.sndPaddleBounce.stop("paddleBounce");
		_root.sndPaddleBounce.start();
		
		_y = _height/2 + 75;
		dy = -dy;
	}
	//quick off bottom of screen fix
	if (_y > Stage.height)
	{
		_root.brickCount = 0;
		
		//_root.sndBlip.stop();
		//_root.sndBlip.start(0,5);
		//_y = Stage.height-120;
		//dy = -dy;
		this.removeMovieClip();
		
		//sound effect
		//_root.sndCrash.stop();
		//_root.sndCrash.start();
		
		_root.score += _root.bank;
		_root.bank = 0;
		_root.multiplier = 1;
		_root.bankBar = (_root.multiplier + " x " + _root.bank);
		
		//put paddle back on target stages
		if( _root.targetWave == 1)
		{
			//print miss!
			_root.textBox._y = 445;
			_root.textBox.info = ("miss !");
			_root.textBox.gotoAndPlay(1);
			
			//put paddle back on target stages
			_root.attachMovie("paddle","paddle", 5);
		}
		//reset juggleJuggleBall
		aiming = 1;
	}
	
}

function checkInvaderCollision()
{
	//loop checks collision on every invader-row and col are the same as in the
	//invader creation loop in the main (root) code	
	//NEED TO GET THESE NUMBERS FROM ROOT SO IT NEVER CHECKS FOR IMPOSSIBLE
	//COLLISIONS THAT EAT PROCESS TIME!!!!
	for (row = 1; row <= _root.endTwerpRow; row++)
	{
   		 for (col = 1; col <= _root.endTwerpCol; col++)
		{	
			if (hitTest("_root.twerp_" + row + "_" + col))
			{
				//_root.sndBlip.stop();
				_root.sndBlip.start();
				//increases speed of juggleJuggleBall with each bounce
				if (dy > 0)
				{
					dy += bounceIncreaseEnemy;//.5
					//trace ("down is working");
				}
				else
				{
					dy -= bounceIncreaseEnemy;//.5;
					//trace ("up is working")
				}
			_root.multiplier += 1;
			//_root.bank += 100;
			_root.bankBar = (_root.multiplier + " x " + _root.bank);
			//dy += 2;//this makes juggleJuggleBall speed up when hitting invaders
			dy = -dy; //bounce in opposite (y) direction
				
			}
		}
	}
}
function checkBrickCollision()
{
	
	
	
	
	
	
	//loop checks collision on every invader-row and col are the same as in the
	//invader creation loop in the main (root) code	
	for (row = 1; row <= juggleJuggleBallEndRow; row++)//6
	{
   		 for (col = 1; col <= juggleJuggleBallEndCol; col++)//9
		{	
			if (hitTest("_root.brick_" + row + "_" + col))
			{
				_root.sndBlip.stop();
				_root.sndBlip.start();
				//brick = eval("_root.brick_" + row + "_" + col);
				
				//trace(brick);
				
				//_root.snd.start(0, 10); 
				//_root.brick.gotoAndPlay(2);
				
				//testing to track specific coordinates of each brick
				num1 = eval("_root.brick_" + row + "_" + col + "._x");
				num2 = eval("_root.brick_" + row + "_" + col + "._y");
      			if(_x > num1)//if juggleJuggleBall hits right side of brick
				{
					if(dx < 0 && _y > num2 - 8.4 && _y < num2 + 8.4)//if juggleJuggleBall is moving left and in an accuracy box on the right side then bounce left
					{
						if(dx < 0)
						{
						dx = -dx;
						}
					}
				}
				if(_x < num1 )//if juggleJuggleBall hits left side of brick
				{
					if(dx > 0 && _y > num2 - 8.4 && _y < num2 + 8.4)//if juggleJuggleBall is moving right and in an accuracy box on the left side then bounce right
					{
						if(dx > 0)
						{
						dx = -dx;
						}
						//dx = -3;
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
				
				//trace(" brick x is " + num1);
				//trace(" brick y is " + num2);
				//trace(" juggleJuggleBall x is " + _x);
				//trace(" juggleJuggleBall y is " + _y);
				
				//brick._x = (col * (brick._width + 5) + colOffset);
      			//brick._y = (row * (brick._height + 5) + rowOffset);
				//var myString:String = ("_root.brick_" + row + "_" + col + "._y");
				//var myNumber:Number = parseInt(myString, 0);
				//trace(Number(myString));
				//trace(stringToNum("_root.brick_" + row + "_" + col + "_y"));
				//dx = getBrickDx("_root.brick_" + row + "_" + col);
				//increases speed of juggleJuggleBall with each bounce
				if (dy > 0)
				{
					dy += bounceIncrease;//.5;//increase speed when hittin brick
					//trace ("brick down is working");
				}
				else
				{
					dy -= bounceIncrease;//.5;//increase speed when hittin brick
					//trace (" brick up is working")
				}
			//setting score stuff
			_root.multiplier += 1;
			_root.bank += 10;
			_root.bankBar = (_root.multiplier + " x " + _root.bank);
			
			//dy = -dy; //bounce in opposite (y) direction
			//accurate bounce
			
			
			//_root.brickCount -=1;
			}
		}
	}
}
function checkPaddleCollision()
{
	//if juggleJuggleBall hits left or right side bounce in opposite direction
	if (hitTest(_root.paddle))
	{
		//_root.sndBlip.stop();
		//_root.sndBlip.start();
		
		//fix for ball appearing to go inside paddle
		if (_y + 6.75 > _root.paddle._y-19)
		{
			//fix for ball appearing to go inside paddle
			_y = _root.paddle._y-19
			
			//adds score if all three balls are launched
			if(_root.juggleBall3.ball3Switch == 1 && _root.juggleBall3.aiming == 0)
			{
				
				_root.sndLaunch.stop();
				_root.sndLaunch.start();
				_root.bonus += 100;
				_root.bankBar = ("bonus " + _root.bonus);
			}
			//if (_root.juggleBall3._y < 360)
			//{
				//canScore = 1;
			//}
			
			dy = -dy
			dx = getDx(_root.paddle);
		}
	}
}




//find exactly where the juggleJuggleBall hit the paddle
function getDx(paddle)
{
relX = _x - _root.paddle._x;
relPerc = relX/_root.paddle._width;
newDx = relPerc * juggleJuggleBallControl;
return newDx;
}

///function getBrickDx(brick)
//{
//relX = _x - ("_root.brick_" + row + "_" + col + "._x");
//relPerc = relX/("_root.brick_" + row + "_" + col + "._width");
//newDx = relPerc * juggleJuggleBallControl;
//return newDx;
//}


function onMouseDown()
{
	if (_root.tallyPanel.panelState == 1)
		{
		_root.tallyPanel.panelState = 2;
		_root.tallyText.gotoAndPlay(61);
		//freeze = 1;
		}
	//as long as you are not aiming cash in points
	//and reset y speed to 0;
if(_root.multiplier > 1)//if multiplier is higher than 1 (so they can't keep "floating" juggleJuggleBall)
{
	if (aiming == 0)//0 means juggleJuggleBall is in play(not aiming)
		{
		freeze = 1;
		storeBank = _root.bank;
		//cash in your bank to points
		_root.bank = _root.bank*_root.multiplier;
		for (i=_root.bank;i > 0;i--)
		{
			
			//_root.bank = i;
			//for (z=10;z>0;z--)
			_root.score +=1;
			//_root.update();
			
			//play sound of tally
			_root.sndCrash.stop();
			_root.sndCrash.start();
			
		}
		//if (_root.multiplier > 0)
		//{
			//if (_root.bank > 0)
			//{
				//_root.bank -= 1;
				//_root.score += 1;
			//}
			//_root.bank = storeBank;
			//_root.multiplier -= 1;
		//}
		freeze = 0;
		
		//_root.score += _root.multiplier*_root.bank;
		_root.bank = 0;
		_root.multiplier = 1;//reset multiplier to 1
		_root.bankBar = (_root.multiplier + " x " + _root.bank);
		
		//if juggleJuggleBall is in top half of screen
		//reset the juggleJuggleBall y speed to 0
		//after cashing in points
		if (_y < 360)
		{
			//dy=_y/90;
			//dy = 0;
			if(dy>0)
			{
				dy=_y/juggleJuggleBallSlow;
			}
			if(dy<0)
			{
				dy=_y/-juggleJuggleBallSlow;
			}
		}
		else//if juggleJuggleBall is in BOTTOM half of screen "catch" the juggleJuggleBall
		{
			//the higher the number the lower the bounce if cashed in
			//in bottom half of screen
			if(dy>0)
			{
				dy=_y/juggleJuggleBallSlow;//80
			}
			if(dy<0)
			{
				dy=_y/-juggleJuggleBallSlow;
			}
					 
			//aiming=2;//2 is a temp state used so the juggleJuggleBall will not immediately
					 //be launched again (because you are holding down launch button)
			//Mouse.enabled = false;
			//Mouse.enabled = true;
			//i = 180;
			//mouse.Left = false;
		}
		
		}//end if aiming==0
				
		}//end check that multiplier is over 0
		
		//if you are aiming the juggleJuggleBall and you click the button
		//do not cash in points and reset juggleJuggleBall speed
		//instead launch juggleJuggleBall at a speed of 10 in a direction
		//according to the juggleJuggleBall's position over the paddle
		if (aiming == 1)
		{
			dx = getDx(_root.paddle);
			//first shot speed default is -8
			//dy = _root.juggleJuggleBallSpeed-11.3;
			dy = -launchSpeed;
			aiming = 0;
			
			
			
			if (ball2Switch == 0)
			{
				_root.attachMovie("juggleBall","juggleBall2", 30);
				_root.juggleBall2.ball2Switch = 1;
				ball2Switch = 1;
			}
			else if(ball2Switch == 1 && ball3Switch == 0)
			{
				_root.attachMovie("juggleBall","juggleBall3", 41);
				//trace("ball 3");
				_root.juggleBall2.ball3Switch = 1;
				_root.juggleBall3.ball2Switch = 1;
				_root.juggleBall3.ball3Switch = 1;
				ball3Switch = 1;
			}
			
			//_root.juggleBall2.aiming = 1;
			
			//turn off paddle in target bonus waves
			if (_root.targetWave == 1)
			{
				_root.paddle.removeMovieClip();
			}
		}
}//end on mouse down function

	//this function moves the aiming state from 2 to 1
	//this now means you can launch the juggleJuggleBall
	function onMouseUp()
{
		if (aiming ==2)//if state is 2 (meaning you just cashed in your points and the juggleJuggleBall was on bottom half of screen)
		aiming=1;//put the juggleJuggleBall in the aiming state (launchable)
		
}
	




function checkRobotCollision()
{
	//loop checks collision on every invader-row and col are the same as in the
	//invader creation loop in the main (root) code	
	//NEED TO GET THESE NUMBERS FROM ROOT SO IT NEVER CHECKS FOR IMPOSSIBLE
	//COLLISIONS THAT EAT PROCESS TIME!!!!
	for (row = 1; row <= 1; row++)
	{
   		 for (col = 1; col <= 8; col++)
		{	
			if (hitTest("_root.robot_" + 1 + "_" + 1))
			{
				//increases speed of juggleJuggleBall with each bounce
				if (dy > 0)
				{
					//dy = -dy;
					//dy += .01;
					//trace ("down is working");
				}
				else
				{
					//dy -= .01;//.5;
					//trace ("up is working")
				}
			//_root.multiplier += 1;
			_root.bank += 1;
			_root.bankBar = (_root.multiplier + " x " + _root.bank);
			//dy += 2;//this makes juggleJuggleBall speed up when hitting invaders
			//trace ("bounce off!")
			//_y += _height;
			//dy = -dy; //bounce in opposite (y) direction
			//dx = -dx;
				
			}
		}
	}
}

function updateScore()
{
	_root.score = _root.score;
	//display the wave number
	
}

}



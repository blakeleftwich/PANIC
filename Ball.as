class Ball extends MovieClip
{
var num1: Number;
var num2: Number;
	
var brick: String;	
	
var freeze: Number;	
var storeBank: Number;	
	
var i:Number;
var z:Number;

var ballSlow: Number;
var ballSpeedx: Number;
var ballSpeedy: Number;
var ballGravity: Number;
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

var limit: Number;

static var ballEndRow: Number;
static var ballEndCol: Number;
//need to find a way to make row and col numbers customizable
//they need to correspond to any row or col number set in game
var row: Number;
var col: Number;

var ballControl: Number;



function Ball()
{
//adjusting for slower framerate
//originally 60fps-adjusting
//for 15fps-optimize later




if (_root.difficulty ==0)
{
ballSlow = 80;
ballSpeedx = 2;
ballSpeedy = 5;
ballGravity = .1;
launchSpeed = 8;//original 7
launchRate = 3;
bounceIncrease = .125;//original.25
bounceIncreaseEnemy = .5;
limit = 18;
}

  if (_root.difficulty ==1)
{
ballSlow = 73;
ballSpeedx = 2.3;
ballSpeedy = 6.3;
ballGravity = .13;
launchSpeed = 9.3;
launchRate = 3.3;
bounceIncrease = .20;//original .1
bounceIncreaseEnemy = .73;//.2
limit = 21;
}

if (_root.difficulty ==2)
{

ballSlow = 60;	
ballSpeedx = 3;
ballSpeedy = 8;
ballGravity = .2;
launchSpeed = 11.3;
launchRate = 4;
bounceIncrease = .3;//original.5
bounceIncreaseEnemy = 1;
limit = 24;

//60fps
//ballSlow = 60;	
//ballSpeedx = 3;
//ballSpeedy = 8;
//ballGravity = .2;
//launchSpeed = 11.3;
//launchRate = 4;
//bounceIncrease = .5;
//bounceIncreaseEnemy = 1;
}

i=0;
freeze = 0;
storeBank = 0;
//_x = _root.paddle._x;
//_y = _root.paddle._y;
aimX = 0;
ax = launchRate;//ax = 4;
dx = ballSpeedx;
//starting verticle ball speed and direction
dy = -ballSpeedy;//default -8
ballControl = 10;
row=1;
col=7;
aiming = 1;

//ballEndRow = 6;//6
//ballEndCol = 9;//9
}

function onEnterFrame()
{
	if (_root.wave == 12)
	{
	//{freeze = 1;
	_x = -200;
	_y = -200;
	}
	
	if(freeze == 0)//if freeze ==1 then don't move
	{
	move();
	
	checkBoundries();
	checkPaddleCollision();
	checkBrickCollision();
	
	
	//if( _root.wave == 4 || _root.wave == 7)
	//{checkInvaderCollision();}
	
	//if( _root.wave == 8 || _root.wave == 9)
	//{checkRobotCollision();}
	//updateScore();
	}//end if freeze
}

function move()
{
	
	if (aiming == 0)
	{
		
		_x += dx;
		_y += dy;
		
		//gravity
		dy += ballGravity;//default .2
		//dy += .05;
	}
	else
	{
		//aiming movement
		//ball goes back and forth over the paddle
		_x = _root.paddle._x + aimX;
		
		aimX += ax;
		
		if ( _x > _root.paddle._x + 30)
		{ax = -launchRate;}
		
		
		if ( _x < _root.paddle._x - 30)
		{ax = launchRate;}
		
		//ball floats right over paddle
		_y = _root.paddle._y - 18;
	}
	
}
function checkBoundries()
{
	//if ball hits left or right side bounce in opposite direction
	if (_x > Stage.width - (_width/2) - 75)
	{
		//sound effect
		_root.sndWallBounce.stop("wallBounce");
		_root.sndWallBounce.start();
	
		_x = Stage.width - (_width/2) - 75;
		dx = -dx;
	}
	if (_x < _width/2 + 75)
	{
	 	//sound effect
		//_root.sndWall.stop("sndWall")
		//_root.sndWall.start();
		_root.sndWallBounce.stop("wallBounce");
		_root.sndWallBounce.start();
		
		_x = _width/2 + 75;
		dx = -dx;
	}
	//if ball hits top or bottom of stage bounce in opposite direction
	if (_y < _height/2 + 75)
	{
		//sound effect
		//_root.sndWall.stop("sndWall")
		//_root.sndWall.start();
		_root.sndWallBounce.stop("wallBounce");
		_root.sndWallBounce.start();
		_y = _height/2 + 75;
		dy = -dy;
	}
	//quick off bottom of screen fix
	if (_y > Stage.height)
	{
		
		_root.sndOffScreen.stop("offScreen")
		_root.sndOffScreen.start();
		//_y = Stage.height-120;
		//dy = -dy;
		
		//sound effect
		//_root.sndCrash.stop();
		//_root.sndCrash.start();
		
		if (_root.bonusStage == 0)
			{
			//cash in bank with no multiplier
			_root.score += _root.bank;
			_root.bank = 0;
			_root.multiplier = 1;
			_root.bankBar = (_root.multiplier + " x " + _root.bank);
			}
			
		if (_root.onBonusWave == 0)
		{
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
		
		//put paddle back on target stages
		if( _root.targetWave == 1)
		{
			//print miss!
			_root.textBox._y = 445;
			_root.textBox.info = ("miss !");
				if(_root.wave < 11 || _root.wave > 67 && _root.wave < 75)
				{
				_root.textBox.gotoAndPlay(1);
				}
			_root.target.removeMovieClip();
			_root.brickCount=0;
			
			//put paddle back on target stages
			_root.attachMovie("paddle","paddle", 5);
		}
		//reset ball
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
				_root.sndBrickSmash.stop("brickSmash")
				//_root.sndWallBounce.start();
				//increases speed of ball with each bounce
				//if (dy > 0)
				//{
					//dy += bounceIncreaseEnemy;//.5
					//trace ("down is working");
				//}
				//else
				//{
					//dy -= bounceIncreaseEnemy;//.5;
					//trace ("up is working")
				//}
			//_root.multiplier += 1;
			//_root.bank += 100;
			//_root.bankBar = (_root.multiplier + " x " + _root.bank);
			//dy += 2;//this makes ball speed up when hitting invaders
			dy = -dy; //bounce in opposite (y) direction
				
			}
		}
	}
}
function checkBrickCollision()
{
	
	
	
	
	
	
	//loop checks collision on every invader-row and col are the same as in the
	//invader creation loop in the main (root) code	
	for (row = 1; row <= ballEndRow; row++)//6
	{
   		 for (col = 1; col <= ballEndCol; col++)//9
		{	
			if (hitTest("_root.brick_" + row + "_" + col))
			{
				//_root.sndBrickSmash.stop("brickSmash");
				//_root.sndBrickSmash.start();
				_root.sndWall.stop("brickBreak")
				_root.sndWall.start();
				
				//brick = eval("_root.brick_" + row + "_" + col);
				
				//trace(brick);
				
				//_root.snd.start(0, 10); 
				//_root.brick.gotoAndPlay(2);
				
				//testing to track specific coordinates of each brick
				num1 = eval("_root.brick_" + row + "_" + col + "._x");
				num2 = eval("_root.brick_" + row + "_" + col + "._y");
      			if(_x > num1)//if ball hits right side of brick
				{
					if(dx < 0 && _y > num2 - 8.4 && _y < num2 + 8.4)//if ball is moving left and in an accuracy box on the right side then bounce left
					{
						if(dx < 0)
						{
						dx = -dx;
						}
					}
				}
				if(_x < num1 )//if ball hits left side of brick
				{
					if(dx > 0 && _y > num2 - 8.4 && _y < num2 + 8.4)//if ball is moving right and in an accuracy box on the left side then bounce right
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
				//trace(" ball x is " + _x);
				//trace(" ball y is " + _y);
				
				//brick._x = (col * (brick._width + 5) + colOffset);
      			//brick._y = (row * (brick._height + 5) + rowOffset);
				//var myString:String = ("_root.brick_" + row + "_" + col + "._y");
				//var myNumber:Number = parseInt(myString, 0);
				//trace(Number(myString));
				//trace(stringToNum("_root.brick_" + row + "_" + col + "_y"));
				//dx = getBrickDx("_root.brick_" + row + "_" + col);
				//increases speed of ball with each bounce
				if (dy > 0)
				{
					//added if statements to restrict ball speed at multiple of 25
					if(_root.multiplier < limit && _root.wave != 1)
					{
					dy += bounceIncrease;//.5;//increase speed when hittin brick
					//trace ("brick down is working");
					}
				}
				else
				{
					if(_root.multiplier < limit && _root.wave != 1)
					{
					dy -= bounceIncrease;//.5;//increase speed when hittin brick
					//trace (" brick up is working")
					}
				}
			if (_root.bonusStage == 0)
			{//setting score stuff
			_root.multiplier += 1;
			_root.bank += 10;
			_root.bankBar = (_root.multiplier + " x " + _root.bank);
			}
			//dy = -dy; //bounce in opposite (y) direction
			//accurate bounce
			
			
			//_root.brickCount -=1;
			}
		}
	}
}
function checkPaddleCollision()
{
	//if ball hits left or right side bounce in opposite direction
	if (hitTest(_root.paddle))
	{
		
		
			
		
		
		//else
		//{
		if (_x + 2 >_root.paddle._x - (_root.paddle._width/2) && _x - 2 < _root.paddle._x + (_root.paddle._width/2))
		{
		_y = (_root.paddle._y - (_root.paddle._height/2) -(_height/2));
		_root.sndPaddleBounce.stop("paddleBounce");
		_root.sndPaddleBounce.start();
		dy = -dy;
		}
		else
		{
			_root.sndPaddleBounce.stop("paddleBounce");
			_root.sndPaddleBounce.start();
			dy = -dy;
		}
		//if (_x + (_width/2) <= _root.paddle._x - (_root.paddle._width/2))
		//{
		//trace("left side")
		//_x = (_root.paddle._x - (_root.paddle._width/2) - (_width/2));
		//_root.paddle._x = _root.paddle._x + (_x + (_width/2));
		//dy = -dy
		//}
		
		//if (_x - (_width/2) >= _root.paddle._x + (_root.paddle._width/2))
		//{
		//_x = (_root.paddle._x + (_root.paddle._width/2) + (_width/2));
		//_root.paddle._x = _root.paddle._x - (_x - (_width/2));
		
		//}
		
		//looks like ball hits paddle
		//trace("hit paddle");
		
		
		
				
		
		dx = getDx(_root.paddle);
	}
}




//find exactly where the ball hit the paddle
function getDx(paddle)
{
relX = _x - _root.paddle._x;
relPerc = relX/_root.paddle._width;
newDx = relPerc * ballControl;
return newDx;
}

///function getBrickDx(brick)
//{
//relX = _x - ("_root.brick_" + row + "_" + col + "._x");
//relPerc = relX/("_root.brick_" + row + "_" + col + "._width");
//newDx = relPerc * ballControl;
//return newDx;
//}


function onMouseDown()
{
	//as long as you are not aiming cash in points
	//and reset y speed to 0;
if (_root.tallyPanel.panelState == 1)
		{
		_root.score += _root.tallyPanel.tempScore;
		_root.tallyPanel.tempScore = 0;
		
		_root.tallyPanel.panelState = 2;
		_root.tallyText.gotoAndPlay(61);
		//freeze = 1;
		}
		
if(_root.multiplier > 1)//if multiplier is higher than 1 (so they can't keep "floating" ball)
{
	
		if (aiming == 0)//0 means ball is in play(not aiming)
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
			_root.bank -=1;
			//_root.score = _root.score;
			
				
			
			//_root.update();
			
			//play sound of tally
			//_root.sndCrash.stop();
			//_root.sndCrash.start();
			
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
		//_root.bank = 0;
		_root.multiplier = 1;//reset multiplier to 1
		_root.bankBar = (_root.multiplier + " x " + _root.bank);
		
		//if ball is in top half of screen
		//reset the ball y speed to 0
		//after cashing in points
		if (_y < 360)
		{
			//dy=_y/90;
			//dy = 0;
			if(dy>0)
			{
				dy=_y/ballSlow;
			}
			if(dy<0)
			{
				dy=_y/-ballSlow;
			}
		}
		else//if ball is in BOTTOM half of screen "catch" the ball
		{
			//the higher the number the lower the bounce if cashed in
			//in bottom half of screen
			if(dy>0)
			{
				dy=_y/ballSlow;//80
			}
			if(dy<0)
			{
				dy=_y/-ballSlow;
			}
					 
			//aiming=2;//2 is a temp state used so the ball will not immediately
					 //be launched again (because you are holding down launch button)
			//Mouse.enabled = false;
			//Mouse.enabled = true;
			//i = 180;
			//mouse.Left = false;
		}
		
		}//end if aiming==0
				
		}//end check that multiplier is over 0
		
		//if you are aiming the ball and you click the button
		//do not cash in points and reset ball speed
		//instead launch ball at a speed of 10 in a direction
		//according to the ball's position over the paddle
		if (aiming == 1 && freeze == 0)
		{
			dx = getDx(_root.paddle);
			//first shot speed default is -8
			//dy = _root.ballSpeed-11.3;
			_root.sndLaunch.stop("launch");
			_root.sndLaunch.start();
			dy = -launchSpeed;
			
			aiming = 0;
			//turn off paddle in target bonus waves
			if (_root.targetWave == 1)
			{
				_root.paddle.removeMovieClip();
			}
		}
}//end on mouse down function

	//this function moves the aiming state from 2 to 1
	//this now means you can launch the ball
	function onMouseUp()
{
		if (aiming ==2)//if state is 2 (meaning you just cashed in your points and the ball was on bottom half of screen)
		aiming=1;//put the ball in the aiming state (launchable)
		
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
				//increases speed of ball with each bounce
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
			//dy += 2;//this makes ball speed up when hitting invaders
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



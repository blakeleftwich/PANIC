class TwerpDebris extends MovieClip
{
var num: Number;
	
var aiming: Number;	
var aimX: Number;	
var ax: Number;	
	
var dx: Number;
var dy: Number;

var relX: Number;
var newDx: Number;
var relPerc: Number;



//need to find a way to make row and col numbers customizable
//they need to correspond to any row or col number set in game
var row: Number;
var col: Number;

var twerpDebrisControl: Number;

function TwerpDebris()
{
//_x = _root.paddle._x;
//_y = _root.paddle._y;
aimX = 0;
ax = 4;
dx = 3;
//starting verticle twerpDebris speed and direction
dy = -8;
twerpDebrisControl = 10;
row=1;
col=7;
aiming = 1;
}

function onEnterFrame()
{
	move();
	checkBoundries();
	checkInvaderCollision();
	checkPaddleCollision();
	checkBrickCollision();
	
}

function move()
{
	if (aiming == 0)
	{
		_x += dx;
		_y += dy;
		
		//gravity
		dy += .2;
	}
	else
	{
		//aiming movement
		//twerpDebris goes back and forth over the paddle
		_x = _root.paddle._x + aimX;
		
		aimX += ax;
		
		if ( _x > _root.paddle._x + 30)
		{ax = -4;}
		
		
		if ( _x < _root.paddle._x - 30)
		{ax = 4;}
		
		//twerpDebris floats right over paddle
		_y = _root.paddle._y - 18;
	}
}
function checkBoundries()
{
	//if twerpDebris hits left or right side bounce in opposite direction
	if (_x > Stage.width - (_width/2) - 75)
	{
		_x = Stage.width - (_width/2) - 75;
		dx = -dx;
	}
	if (_x < _width/2 + 75)
	{
	 	_x = _width/2 + 75;
		dx = -dx;
	}
	//if twerpDebris hits top or bottom of stage bounce in opposite direction
	if (_y < _height/2 + 75)
	{
		_y = _height/2 + 75;
		dy = -dy;
	}
	//quick off bottom of screen fix
	if (_y > Stage.height)
	{
		//_y = Stage.height-120;
		//dy = -dy;
		_root.score += _root.bank;
		_root.bank = 0;
		_root.multiplier = 0;
		_root.bankBar = (_root.multiplier + " x " + _root.bank);
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
			if (hitTest("_root.invader_" + row + "_" + col))
			{
				//increases speed of twerpDebris with each bounce
				if (dy > 0)
				{
					dy += .5;
					//trace ("down is working");
				}
				else
				{
					dy -= .5;
					//trace ("up is working")
				}
			_root.multiplier += 1;
			_root.bank += 100;
			_root.bankBar = (_root.multiplier + " x " + _root.bank);
			dy += 2;//this makes twerpDebris speed up when hitting invaders
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
	for (row = 1; row <= 6; row++)
	{
   		 for (col = 1; col <= 9; col++)
		{	
			if (hitTest("_root.brick_" + row + "_" + col))
			{
				//var myString:String = ("_root.brick_" + row + "_" + col + "._y");
				//var myNumber:Number = parseInt(myString, 0);
				//trace(Number(myString));
				//trace(stringToNum("_root.brick_" + row + "_" + col + "_y"));
				//dx = getBrickDx("_root.brick_" + row + "_" + col);
				//increases speed of twerpDebris with each bounce
				if (dy > 0)
				{
					dy += .5;//increase speed when hittin brick
					//trace ("brick down is working");
				}
				else
				{
					dy -= .5;//increase speed when hittin brick
					//trace (" brick up is working")
				}
			//setting score stuff
			_root.multiplier += 1;
			_root.bank += 10;
			_root.bankBar = (_root.multiplier + " x " + _root.bank);
			
			dy = -dy; //bounce in opposite (y) direction
			//accurate bounce
			
			
			_root.brickCount -=1;
			}
		}
	}
}
function checkPaddleCollision()
{
	//if twerpDebris hits left or right side bounce in opposite direction
	if (hitTest(_root.paddle))
	{
		dy = -dy
		dx = getDx(_root.paddle);
	}
}




//find exactly where the twerpDebris hit the paddle
function getDx(paddle)
{
relX = _x - _root.paddle._x;
relPerc = relX/_root.paddle._width;
newDx = relPerc * twerpDebrisControl;
return newDx;
}

///function getBrickDx(brick)
//{
//relX = _x - ("_root.brick_" + row + "_" + col + "._x");
//relPerc = relX/("_root.brick_" + row + "_" + col + "._width");
//newDx = relPerc * twerpDebrisControl;
//return newDx;
//}


function onMouseDown()
{
	//as long as you are not aiming cash in points
	//and reset y speed to 0;
	if (aiming == 0)
		{
		_root.score += _root.multiplier*_root.bank;
		_root.bank = 0;
		_root.multiplier = 0;
		_root.bankBar = (_root.multiplier + " x " + _root.bank);
		
		//reset the twerpDebris y speed to 0
		dy = 0;
		}
	
	//if you are aiming the twerpDebris and you click the button
	//do not cash in points and reset twerpDebris speed
	//instead launch twerpDebris at a speed of 10 in a direction
	//according to the twerpDebris's position over the paddle
	if (aiming == 1)
		{
		dx = getDx(_root.paddle);
		//first shot speed default is -8
		dy = -10;
		aiming = 0;
		}
	
	
}




}

class NormalBall extends MovieClip
{

var dx: Number;
var dy: Number;

var relX: Number;
var newDx: Number;
var relPerc: Number;

//need to find a way to make row and col numbers customizable
//they need to correspond to any row or col number set in game
var row: Number;
var col: Number;

var normalBallControl: Number;

function NormalBall()
{
_x = Stage.width/2;
_y = Stage.height-220;
dx = 3;
//starting verticle normalBall speed and direction
dy = -3;
normalBallControl = 10;
row=1;
col=7;
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
	_x += dx;
	_y += dy;
	
	//gravity
	dy += .2;
}
function checkBoundries()
{
	//if normalBall hits left or right side bounce in opposite direction
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
	//if normalBall hits top or bottom of stage bounce in opposite direction
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
				//increases speed of normalBall with each bounce
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
			_root.multiplier += 1;
			_root.bank += 100;
			_root.bankBar = (_root.multiplier + " x " + _root.bank);
			//dy += 2;//this makes normalBall speed up when hitting invaders
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
				//increases speed of normalBall with each bounce
				//if (dy > 0)
				//{
					//dy += .5;//increase speed when hittin brick
					//trace ("brick down is working");
				//}
				///else
				//{
					//dy -= .5;//increase speed when hittin brick
					//trace (" brick up is working")
				//}
			//setting score stuff
			_root.multiplier += 1;
			_root.bank += 10;
			_root.bankBar = (_root.multiplier + " x " + _root.bank);
			dy = -dy; //bounce in opposite (y) direction
			_root.brickCount -=1;
			}
		}
	}
}
function checkPaddleCollision()
{
	//if normalBall hits left or right side bounce in opposite direction
	if (hitTest(_root.paddle))
	{
		dy = -dy
		dx = getDx(_root.paddle);
	}
}




//find exactly where the normalBall hit the paddle
function getDx(paddle)
{
relX = _x - _root.paddle._x;
relPerc = relX/_root.paddle._width;
newDx = relPerc * normalBallControl;
return newDx;
}

function onMouseDown()
{

	_root.score += _root.multiplier*_root.bank;
	_root.bank = 0;
	_root.multiplier = 0;
	_root.bankBar = (_root.multiplier + " x " + _root.bank);
	if (dy > 0)
	{dy = 8;}
	if (dy < 0)
	{dy = -8;}

}


}

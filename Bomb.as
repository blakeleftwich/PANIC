class Bomb extends MovieClip
{

var dx: Number;
var dy: Number;

//need to find a way to make row and col numbers customizable
//they need to correspond to any row or col number set in game

var row: Number;
var col: Number;

var BombControl: Number;

function Bomb()
{
dx = 0;
dy = 6;

BombControl = 10;
row=1;
col=7;
}

function onEnterFrame()
{
	move();
	checkBoundries();
	checkPaddleCollision();
	
}

function move()
{
	_x += dx;
	_y += dy;
}
function checkBoundries()
{
	//if Bomb hits top or bottom of stage bounce in opposite direction
	if (_y > Stage.height)
	{
		this.removeMovieClip();
	}
}

function checkPaddleCollision()
{
	//if Bomb hits left or right side bounce in opposite direction
	if (hitTest(_root.paddle))
	{
		this.removeMovieClip();
	}
}






}

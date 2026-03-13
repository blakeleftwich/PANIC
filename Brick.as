class Brick extends MovieClip
{

var i: Number;

var collisionOff: Number;

var ballNumber;

//var dy: Number;

function Brick()
{

//will never have more than 5 balls
collisionOff = 0;
ballNumber=1;
_x = 20;
_y = 40;
//dy = .1;
}

function onEnterFrame()
{
	
	if (collisionOff == 0)
	{
		if (_root.ballType == 1)
		{checkBallCollision();}
		else if (_root.ballType == 0)
		{checkClassicBallCollision();}
	}
	
	if( _root.wave == 15)
	{checkRobotCollision();}
	
	//_y += dy;
	
	//dy += .009*Math.sin(-1);
	
	//checkBrickCollision();
	
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
		//destroy this brick		
		//this.removeMovieClip();
		collisionOff = 1;
		//trace("collisionOff = " + collisionOff);
		//_root.snd.start(0, 10); 
		
		gotoAndPlay(2);
		
		//replace this brick with an animation of explosion
		//called brickDestroy for instant collision
		//_root.attachMovie("brickDestroy", "brickDestroy", 111111111())
		//{
			//_root.brickDestroy._x = _x;
			//_root.brickDestroy._y = _y;
			//this.removeMovieClip();
		//}
		
		
		
		}
		
	}
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
		//destroy this brick		
		collisionOff = 1;
		//this.removeMovieClip();
		gotoAndPlay(2);
		}
		
	}
}

function checkRobotCollision()
{
	if (hitTest("_root.robot"))
		{
		//destroy this brick		
		this._y += 68;
		//this.removeMovieClip();
		}
}

//function checkBrickCollision()
//{
	//if (hitTest("_root.brick"))
		//{
		//destroy this brick		
		//this._y += 15;
		//this.removeMovieClip();
		//}
//}

}

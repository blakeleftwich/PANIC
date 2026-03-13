class Tally extends MovieClip
{

var dx: Number;
var dy: Number;

var row: Number;
var col: Number;

var i: Number;

var ballNumber;

var panelState: Number;
var tempScore: Number;

function Tally()
{
//speed moving left to right
//dx = 2;
dy = 12;
//will never have more than 5 balls
ballNumber=5;
_x=276;
_y=-270;
panelState = 0;
tempScore = 0;
i = 2;
}

function onEnterFrame()
{
	move();
	//checkBoundries();
	//checkBrickCollision();
	//checkBallCollision();
	//checkBomb();
}

function move()
{
	
	if(panelState == 1)
	{
		_root.ball0._y = -1700;
		_root.classicBall0._x = -1700;
		_root.ball0.freeze=1;
		//start moving the panel downward
		_y += dy;
		
		//if panel passes this point
		if (_y > 139)
		{
			//retrieve the appropriate message
			_root.tallyText.info = (_root.tallyMessage);
			//play the message
			_root.tallyText.gotoAndPlay(i);
			i++
			if(i>60)
			{
				i=60;
			}
		}
		//if panel hits the bottom
		if (_y > 310)
		{
			//if bonus stage is not happening
			//if(_root.bonusStage == 0)
			//{
				//make temp score equal bank times multiplier***currently calculating wrong
				//tempScore =_root.bank*_root.multiplier;//_root.bank * _root.multiplier;
				//tempScore =_root.bank*_root.multiplier;//**************
				//_root.bank = tempScore;
				//_root.multiplier = 1;
				//trace("tempScore " + tempScore + " bank " + _root.bank + " multiplier " + _root.multiplier + " score " + _root.score)
				//_root.bank = tempScore;
				//_root.multiplier = 1;
				
			//}
			//else
			//{
				//if bonus stage is happeneing let the tempScore equal the bonus points
				//tempScore = _root.bonus;
				//_root.bank = _root.bonus;
			//}
			//i = 60;
			//_root.tallyText._y=.2
			
			//while tempScore is greater than 0
			
			//if(_root.score < _root.score+tempScore)
			if(tempScore > 0)//tempScore
			{
				//keep panel at this spot
				_y=310;
				//_root.scoreBox._y = 575;
				
				//keep the tally message visible
				_root.tallyText.gotoAndPlay(59);
				
			   //if(i<61)
			    //{
				  	//_root.tallyText.gotoAndPlay(i);
			  		//i++;
				//}
				
				//score goes up with a sound
				_root.sndBlip.start();
				//score goes up by 10
				_root.score+=10;
				//tempScore points go down by 10
				tempScore-=10;
				//bank goes down by 10
				//_root.bank-=10;**********************
				//if(_root.bank = 0)
				//{tempScore = 0;}
				//_root.bankBar = ("total bank " + _root.bank);
				_root.multiplier = 1;
				_root.bank = 0;
				
				_root.bonus = 0;
				
					if (_root.wave == 12 || _root.wave == 18 || _root.wave == 24 || _root.wave == 30)
					{
					_root.bankBar = ("bonus " + tempScore);
					}
					else
					{
					_root.bankBar = ("bank " + tempScore);
					}
				_root.ball0._y = -1700;//optional put the ball off screen
			}
			else
			{
				//_root.tallyText.gotoAndPlay(61);
				//panelState = 0;
				_y=310;
				//_root.scoreBox._y = 575;
			}
		}
	}
	else if (panelState == 2)
	{
		_root.ball0._y = -1700;
		_root.classicBall0._y = -1700;
		_root.ball0.freeze = 1;
		//_root.tallyText.gotoAndPlay(61);
		_y -= dy;
		//_root.scoreBox._y -= dy;
		if (_y < -265)
		{
			_y=-270;
			//_root.scoreBox._y = -204;//***
			panelState = 0;
			//_root.ball0.aiming = 1;
			_root.brickCount = 0;//goes to next wave*******************
		}
		if(_root.scoreBox._y < 1)
		{
			_root.scoreBox._y = 1;
		}
	}
	
	
	//dy += .005*Math.sin(dx);
	
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
		_root.brickCount-=1;
		//destroy this tally		
		this.removeMovieClip();
		}
		
	}
}

	
}

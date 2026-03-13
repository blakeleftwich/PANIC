class Opponent extends MovieClip
{
var dx:Number;

var pongScore:Number;
var opponentScore:Number;
var angleBuffer:Number;

function Opponent()
{

_x = Stage.width/2
_y = 100.5;

 _root.classicBall.aiming = 0;
 _root.classicBall.dx = 0;
 _root.classicBall.dy = _root.classicBall.ballSpeedy;
 _root.classicBall._x = Stage.width/2;
 _root.classicBall._y = Stage.height/2 + 30;

 //_root.score = ("0");
 _root.bankBar = ("bonus " + _root.bonus);

pongScore = 0;
opponentScore = 0;

angleBuffer = 3.6;

//dx = 3;
}

function onEnterFrame()
{
	move();
	checkBoundries();
	checkBallCollision();
	checkBallLocation();
	_root.classicBall0.timer();
	//go to next level if score hits 10
	
	
}

function move()
{
	_root.classicBall0.aiming = 0;
 	//_root.classicBall0._y = Stage.height/2 + 30;
	//_x = dx;
	if (_root.classicBall0.freeze == 0)
		{
			if(_root.classicBall0._x > _x+4 )
			{
				_x += ((_root.difficulty + 1.7) + pongScore*.1);//was 3.7
			}
			else if(_root.classicBall0._x < _x-4 )
			{
				_x -= ((_root.difficulty + 1.7) + pongScore*.1);//was 3.7
			}
		}
		else if (_root.classicBall0.freeze == 1)
		{
			_root.classicBall0._x = Stage.width/2;
 			_root.classicBall0._y = Stage.height/2 + 30;
		}
	
}
function checkBoundries()
{
	if (_x > Stage.width -(_width/2) - 74)
	{
		_x = Stage.width -(_width/2) - 74;
	}
	
	if (_x < (_width/2) + 75)
		{
			_x = (_width/2) + 75;
		}
	
}

function checkBallCollision()
{
	if (hitTest(_root.classicBall0))
	{
		if (_root.classicBall0._x + 1 >_x - (_width/2) && _root.classicBall0._x - 1 < _x + (_width/2))
		{
		_root.classicBall0._y = (_y + (_height/2) +(_root.classicBall0._height/2));
		_root.sndOpponentBounce.stop("opponentBounce");
		_root.sndOpponentBounce.start();
		_root.classicBall0.dy = -_root.classicBall0.dy;
		}
		else
		{
			_root.sndOpponentBounce.stop("opponentBounce");
			_root.sndOpponentBounce.start();
			_root.classicBall0.dy = -_root.classicBall0.dy;
		}
		//_root.sndOpponentBounce.stop("opponentBounce");
		//_root.sndOpponentBounce.start();
		//_root.classicBall0.dy = -_root.classicBall0.dy;
		_root.classicBall0.dx = (_root.classicBall0.getDx(_root.opponent)/angleBuffer);
	}
}

function checkBallLocation()
{
	if(_root.classicBall0._y < _y-10)
	{
					
			//_root.bankBar = (pongScore);
			
			pongScore += 1;
			
			//_root.bonus += 100;
			//_root.bankBar = ("bonus " + _root.bonus);
			
			//if(pongScore > 6)
			//{
				//_root.brickCount = 0;
				//this.removeMovieClip();
				
			//}
			angleBuffer -=.2;
			
			if(pongScore > 9)
			{
				//_root.brickCount = 0;
				
			}
			
			_root.classicBall0.freeze = 1;
			_root.classicBall0.dx = Math.ceil((Math.random()*6)-3);
			_root.classicBall0.dy = -_root.classicBall0.ballSpeedy;
						
			
			if(pongScore > 1)
			{
				
				_root.textBox._y = 445;
				
				_root.textBox.info = ("goal !");
				
				_root.bonus += 200;
			_root.bankBar = ("bonus " + _root.bonus);
				
				
			}
				//if(pongScore < 7)
				//{
					_root.sndBlip.stop("blip");
					_root.sndBlip.start(0,7);
					_root.textBox.gotoAndPlay(1);
				//}
	}
	
	if(_root.classicBall0._y > Stage.height)
	{
		
			
						
			opponentScore += 1;
			
			if(opponentScore > 9)
			{
				//_root.brickCount = 0;
				
			}
			_root.classicBall0.freeze = 1;
			_root.classicBall0.dx = Math.ceil((Math.random()*6)-3);
			_root.classicBall0.dy = _root.classicBall0.ballSpeedy;
			
			
			//_root.score = (opponentScore);
						
			_root.textBox._y = 445;
				
				_root.brickCount = 0;
				this.removeMovieClip();
				
			//_root.textBox.info = ("ouch !");
					
			//_root.textBox.gotoAndPlay(1);
		
	}
	
	
}

function drawScore()
{
	_root.score = ("123");
	_root.bankBar = ("321");
}


}

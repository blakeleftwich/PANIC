class Target extends MovieClip
{

var dx: Number;
var dy: Number;

var row: Number;

var col: Number;

var i: Number;

var ballNumber;

function Target()
{
//speed moving left to right
//dx = 4;
//dy = .2;
//will never have more than 5 balls
ballNumber=1;

_x = 200;
_y = 280;


}

function onEnterFrame()
{
	//move();
	//checkBoundries();
	//checkBrickCollision();
	checkBallCollision();
	//checkBomb();
}

function move()
{
	
	
	_x += dx;
	_y += dy;
	
	
	
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
      //_root.bomb = eval(_root.bomb0);
     // _root.bomb._x = _root.target_1_1._x;
	 // _root.bomb._y = _root.target_1_1._y + dy;
}

function checkBoundries()
{
	if (_x > Stage.width -(_width/2) - 74)
	{
	for (i = 0; i < 40; i++)
		{_y += 1;	}
	dx = -dx;
	}
	
	if (_x < (_width/2) + 75)
		{
		for (i = 0; i < 40; i++)
		{_y += 1;	}
		dx = -dx;
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
				for (i = 0; i < 2; i++)
					{_y -= 1;	
					
					
					}
				}
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
		//destroy this target		
		//trace("hit");
		if(_root.wave < 11 || _root.wave > 67 && _root.wave < 76)//**********
		{
		_root.ball0.aiming = 1;
		}
		//raw  =Math.random();
		//col = (raw*300)+100;
		//create next target in method on main program
		
		//_root.textBox._y = 331.8;
		//if(_root.wave < 11)
		//{
			_root.brickCount=0;
		//}
		_root.sndMelody.stop();
  		_root.sndMelody.start(1.6,1);
		_root.textBox._y = 445;
		_root.textBox.info = ("hit !");
		
		_root.bonus += 200;
		_root.bankBar = ("bonus " + _root.bonus);
				if(_root.wave < 11 || _root.wave > 67 && _root.wave < 75)
		{
			_root.textBox.gotoAndPlay(1);
		}
		//_root.wave = 19;
		
		//_root.wave+=1;
		//trace("wave = " + _root.wave);
		
		//put paddle back
		_root.attachMovie("paddle","paddle", 5);
		
		this.removeMovieClip();
		}
		
		//if(_root.ball0._y < _y-40)
		//{
			//trace("miss");
		//}
		
	}
}

	function checkBomb()
	{
		if(_x> Stage.width/2)
		{
			if(Math.ceil(Math.random()*6) > 2)
				{
				_root.targetsBomb();
				_root.nextBomb +=1;
				}
		}
	}
}

class BaseballDiamond extends MovieClip
{

function BaseballDiamond()
{
_x = Stage.width/2;
_y = Stage.height/2;

}

function onEnterFrame()
{
	//move();
	//checkBoundries();
	
}

function move()
{
	_x = _root._xmouse;
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

}

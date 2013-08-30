	//script for takeoff and landing
	//from/to respawns

	_veh=_this select 0;//aircraft
	_action=_this select 1;//true - take off; false - landing

	if (_action) then
	{
		//calculate respawn position and velocity
		_dir=getDir _veh;
		_vel=[150*(sin _dir),150*(cos _dir),0];
		_pos=getPos _veh;	
		_pos=[_pos select 0,_pos select 1,250];
			
		//move plane to the air
		titleCut["","black out",1];	
		sleep 2;	
		player action ["engine on",_veh];
		_veh setPos _pos;
		_veh setDir _dir;
		_veh setVelocity _vel;	
		player action ["LandGearUp", _veh];
		titleCut["","black in",1];		
		
		//dunno why, but planes are able to retract
		//gear only after setDamage 0 
		_dam=getDammage _veh;
		_veh setDamage 0;
		_veh setDamage _dam;
		
		sleep 1;
		//restart GUI
		Local_GUIRestart=true;
	}
	else
	{
		//calculate landing position
		_pos=getPosATL Local_FriendlyBaseFlag;
		_pos=[_pos select 0,_pos select 1,[0,Config_RespawnSize]] call Func_Client_CalculateSpawnPos;
		_dir=getDir _veh;
		titleCut["","black out",1];	
		player action ["LandGear", _veh];
		sleep 2;
		player action ["engine off",_veh];
		_veh setVelocity [0,0,0];
		_veh setDir _dir;
		_veh setPos _pos;
		titleCut["","black in",1];
		
		sleep 1;
		//restart GUI
		Local_GUIRestart=true;
	};
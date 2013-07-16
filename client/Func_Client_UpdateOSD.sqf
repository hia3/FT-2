
	#define ColorTargetTankCommander "#75FF63"
	#define __LASERDIST 5000

	disableSerialization;
	
	_display=uiNamespace getVariable "GUI";
		
	_showcontrol=
	{
		private["_control","_name","_pos"];
		
		_control=_this select 0;
		_name=_this select 1;
		_pos=_this select 2;
			
		_control ctrlSetStructuredText _name;
		_control ctrlSetPosition [(_pos select 0)-0.125,_pos select 1];
		_control ctrlCommit 0;
		waitUntil {ctrlCommitted _control};
	};
		
	_hidecontrol=
	{
		private["_control"];
		_control=_this;
		_control ctrlSetStructuredText parseText "";			
	};
	
	_TimerC=0;
	_TimerD=0;
	
	_playerInVehicle=false;
	_commanderScanner=false;
	_hasLaserScanner=false;
	_hasCommander=false;
	_hasAARadar=false;
	_hasGuidedMissile=false;
	
	_commanderMarkersShown=false;
	_teamMarkersShown=false;
	_medicMarkersShown=false;
	_laserTargetsShown=false;
	_gunnerOrdersShown=false;
	_driverOrdersShown=false;
	_radarTargetShown=false;
	_missileTargetShown=false;
	
	_cursor=_display displayCtrl 6090;
	_lasers=[];
	
	_targets=if (Local_PlayerSide==east) then 
	{["LaserTargetEBase","LaserTargetE","LaserTargetEStatic","NVG_TargetE","NVG_TargetC"]} else {["LaserTargetWBase","LaserTargetW","LaserTargetWStatic","NVG_TargetW"]};
	
	while{!Global_GameEnded&&!visibleMap&&Local_GUIActive&&(alive player)&&!Local_GUIRestart}do
	{
		_timer=time;
		if (_TimerC<_timer) then
		{
			_TimerC=_timer+0.5;
			if (Local_PlayerVehicle==player) then
			{
				_playerInVehicle=false;
				_cursor ctrlSetText "";
			}
			else
			{				
				_playerInVehicle=true;
				
				if (Local_CrosshairShow) then
				{
					if (Local_PlayerVehicle isKindOf "Air") then
					{
						_cursor ctrlSetText "a3\ui_f\data\IGUI\Cfg\Cursors\selected_ca.paa";
					}
					else
					{
						_cursor ctrlSetText "";
					};
				}
				else
				{
					_cursor ctrlSetText "";
				};
			};
			

			if (_playerInVehicle && (player==(commander Local_PlayerVehicle)) && (cameraView=="Gunner") && (({Local_PlayerVehicle isKindOf _x} count System_HaveScannerVehicleTypes)>0)) then
			{
				_commanderScanner=true;
			}
			else
			{
				_commanderScanner=false;
			};

			
			if (_playerInVehicle && (({Local_PlayerVehicle isKindOf _x} count System_HaveScannerVehicleTypes)>0)) then
			{
				_hasCommander=true;
			}
			else
			{
				_hasCommander=false;
			};
			
			Local_PlayerIsMedic = ("Medikit" in (items player));
			
			if (_playerInVehicle && !_commanderScanner && ((player==driver Local_PlayerVehicle) || (player==gunner Local_PlayerVehicle)) && (({Local_PlayerVehicle isKindOf _x} count System_HaveDesignatorVehicleTypes)>0)) then
			{
				_hasLaserScanner=true;
				if (_TimerD<_timer) then
				{

					_lasers=nearestobjects [Local_PlayerVehicle,_targets,__LASERDIST];
					_TimerD=_timer+5;

				};				
			}
			else
			{
				_hasLaserScanner=false;
			};
			
			if (_playerInVehicle && (player==gunner Local_PlayerVehicle) && (cameraView=="GUNNER") && (({Local_PlayerVehicle isKindOf _x} count System_HaveAARadarVehicleTypes)>0) && ((currentWeapon Local_PlayerVehicle) in System_HaveAARadarVehicleDatas)) then
			{
				_hasAARadar=true;			
			}
			else
			{
				_hasAARadar=false;
			};
			
			if (_playerInVehicle && (player==gunner Local_PlayerVehicle) && (cameraView=="GUNNER") && ((currentWeapon Local_PlayerVehicle) in System_GuidedMissileTypes)) then
			{
				_hasGuidedMissile=true;			
			}
			else
			{
				_hasGuidedMissile=false;
			};
		};
		

		if (_commanderScanner) then
		{
			_pos=screenToWorld [0.5,0.5];			
				
			if ((_pos distance Local_PlayerVehicle) < viewDistance) then
			{
				_obj=nearestobjects [_pos,["LandVehicle"],50];
				_obj=_obj-[Local_PlayerVehicle];
				_cnt=(count _obj) min 5;				
				_i=0;
				while {_i<_cnt} do
				{
					_target=_obj select _i;
					_control=_display displayCtrl (6080+_i);					
					_pos=getPosATL _target;
					_pos set [2,1];
					
					_pos=worldToScreen _pos;		
					
					if ((count _pos)!=0) then
					{		
						_name="<t size='%1' color='%2' align='center'><img image='a3\ui_f\data\map\Markers\NATO\o_unknown.paa'></t>";					
						_name=parseText format[_name,1.0,ColorTargetTankCommander];							
						[_control,_name,_pos] call _showcontrol
					}
					else
					{
						_control call _hidecontrol;
					};
					
					_i=_i+1;					
					_commanderMarkersShown=true;
				};
				if (_commanderMarkersShown) then
				{
					while {_i<5} do
					{
						_control=_display displayCtrl (6080+_i);	
						_control call _hidecontrol;					
						_i=_i+1;
					};				
				};				
			};
		}
		else
		{
			if (_commanderMarkersShown) then
			{
				_i=0;
				while {_i<5} do
				{
					_control=_display displayCtrl (6080+_i);	
					_control call _hidecontrol;				
					_i=_i+1;
				};
				_commanderMarkersShown=false;
			};			
		};

		
		if (_hasCommander) then
		{
			if ((count Local_TankDrivePos) > 0) then
			{
				_control=_display displayCtrl 6091;
				_pos=worldToScreen Local_TankDrivePos;
				if ((count _pos)!=0) then
				{
					_pos set [1,(_pos select 1)-0.06];
					_name=parseText format["<t size='1' shadow='true' align='center' color='#FFFFFF'>%1m</t><br/><t size='1.2' color='#00FF00' align='center'><img image='a3\ui_f\data\map\Markers\Military\marker_ca.paa'></t>",round(Local_TankDrivePos distance Local_PlayerVehicle)];
					[_control,_name,_pos] call _showcontrol;					
					_driverOrdersShown=true;
				}				
				else
				{
					_control call _hidecontrol;
				};
			}
			else
			{
				if (_driverOrdersShown) then
				{
					_control=_display displayCtrl 6091;
					_control call _hidecontrol;	
					_driverOrdersShown=false;
				};				
			};
			if ((count Local_TankFirePos) > 0) then
			{
				_control=_display displayCtrl 6092;
				_pos=worldToScreen Local_TankFirePos;
				if ((count _pos)!=0) then
				{
					_pos set [1,(_pos select 1)-0.06];
					_name=parseText format["<t size='1' shadow='true' align='center' color='#FFFFFF'>%1m</t><br/><t size='2.0' color='#FF0000' align='center'><img image='a3\ui_f\data\map\GroupIcons\selector_selectedmission_ca.paa'></t>",round(Local_TankFirePos distance Local_PlayerVehicle)];
					[_control,_name,_pos] call _showcontrol;
					_gunnerOrdersShown=true;
				}
				else
				{
					_control call _hidecontrol;
				};
			}
			else
			{
				if (_gunnerOrdersShown) then
				{
					_control=_display displayCtrl 6092;
					_control call _hidecontrol;
					_gunnerOrdersShown=false;
				};				
			};
		}
		else
		{
			if (_gunnerOrdersShown || _driverOrdersShown) then
			{
				_control=_display displayCtrl 6091;
				_control call _hidecontrol;
				_control=_display displayCtrl 6092;
				_control call _hidecontrol;
				_gunnerOrdersShown=false;
				_driverOrdersShown=false;
			};				
		};
		
		if (_hasLaserScanner) then
		{			
			_cnt=count _lasers;				
			_i=0;
			_j=0;
			while {(_i<_cnt) && (_j<5)} do
			{
				_target=_lasers select _i;
				if (!isNull _target) then
				{
					_control=_display displayCtrl (6080+_j);					
					_pos=getPosATL _target;
					
					_pos=worldToScreen _pos;							
					
					if ((count _pos)!=0) then
					{								
						_pos set [1,(_pos select 1)-0.08];
						_name=parseText format["<t size='0.8' shadow='true' align='center' color='#FF0000'>Laser</t><br/><t size='0.8' shadow='true' align='center' color='#FFFFFF'>%1m</t><br/><t size='2.0' color='#FF0000' align='center'><img image='a3\ui_f\data\map\GroupIcons\selector_selectedmission_ca.paa'></t>",round(_target distance Local_PlayerVehicle)];
						[_control,_name,_pos] call _showcontrol
					}
					else
					{
						_control call _hidecontrol;
					};
					_j=_j+1;					
					_laserTargetsShown=true;
				};					
				_i=_i+1;
			};
			if (_laserTargetsShown) then
			{
				while {_j<5} do
				{
					_control=_display displayCtrl (6080+_j);	
					_control call _hidecontrol;					
					_j=_j+1;
				};
			};
		}
		else
		{
			if (_laserTargetsShown) then
			{
				_i=0;
				while {_i<5} do
				{
					_control=_display displayCtrl (6080+_i);	
					_control call _hidecontrol;				
					_i=_i+1;
				};
				_laserTargetsShown=false;
			};			
		};
		
		if (_hasAARadar) then
		{			
			if (!isNull System_RadarTrackedAircraft) then
			{
				_control=_display displayCtrl 6080;					
				_pos=getPosATL System_RadarTrackedAircraft;
				_pos set [2,(_pos select 2)+2];
				
				_pos=worldToScreen _pos;						
				
				if ((count _pos)!=0) then
				{				
					_pos set [1,(_pos select 1)-0.018];
					_name=parseText "<t size='2.0' color='#FF0000' align='center'><img image='pic\ca\ui\data\ui_cursor_target_active_ca.paa'></t>";
					[_control,_name,_pos] call _showcontrol;
				}
				else
				{
					_control call _hidecontrol;
				};
				_radarTargetShown=true;
			}
			else
			{
				if (_radarTargetShown) then
				{
					_control=_display displayCtrl 6080;	
					_control call _hidecontrol;				
					_radarTargetShown=false;
				};	
			};
		}
		else
		{
			if (_radarTargetShown) then
			{
				_control=_display displayCtrl 6080;	
				_control call _hidecontrol;				
				_radarTargetShown=false;
			};			
		};
		
		if (_hasGuidedMissile) then
		{			
			if (!isNull cursorTarget) then
			{
				_control=_display displayCtrl 6080;					
				
				_name=parseText "<t size='5.0' color='#FFBB35' align='center'><img image='a3\ui_f\data\IGUI\Cfg\WeaponCursors\bomb_gs.paa'></t>";
				[_control,_name,[0.5,0.436]] call _showcontrol;
				_missileTargetShown=true;
			}
			else
			{
				if (_missileTargetShown) then
				{
					_control=_display displayCtrl 6080;	
					_control call _hidecontrol;				
					_missileTargetShown=false;
				};	
			};
		}
		else
		{
			if (_missileTargetShown) then
			{
				_control=_display displayCtrl 6080;	
				_control call _hidecontrol;				
				_missileTargetShown=false;
			};			
		};
		
		sleep 0.01;
	};
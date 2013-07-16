	if (!local player) exitWith{};
	
	_sh=_this select 0;

	sleep 0.7;
	_source2 = "#particlesource" createVehicleLocal getpos _sh;
	_source2 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 7, 48, 1], "", "Billboard", 1, 10, [0, 0, 0],
				[0, 0, 0.5], 0, 1.277, 1, 0.025, [0.5, 8, 12, 15], [[1, 1, 1, 0.7],[1, 1, 1, 0.5], [1, 1, 1, 0.25], [1, 1, 1, 0]],
				[0.2], 1, 0.04, "", "", _sh];
	_source2 setParticleRandom [2, [0.3, 0.3, 0.3], [1.5, 1.5, 1], 20, 0.2, [0, 0, 0, 0.1], 0, 0, 360];
	_source2 setDropInterval 0.2;

	_source3 = "#particlesource" createVehicleLocal getpos _sh;
	_source3 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 7, 0], "", "Billboard", 1, 5, [0, 0, 0],
				[0, 0, 0.5], 0, 1.277, 1, 0.025, [0.5, 8, 12, 15], [[1, 1, 1, 1],[1, 1, 1, 1], [1, 1, 1, 0.5], [1, 1, 1, 0]],
				[0.2], 1, 0.04, "", "", _sh];
	_source3 setParticleRandom [2, [0.3, 0.3, 0.3], [1.5, 1.5, 1], 20, 0.2, [0, 0, 0, 0.1], 0, 0, 360];
	_source3 setDropInterval 0.15;
	
	sleep (55+random 3);
	deletevehicle _source2;
	deletevehicle _source3;
		
	if (!isNull _sh) then
	{
		deletevehicle _sh;
	};
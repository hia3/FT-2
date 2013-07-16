/**/
_tank=_this;

 if (player in _tank) then {_tank vehicleRadio "grenade_explo"} else {_tank say "grenade_explo_say"};

 sleep 4;
 
_sm = "#particlesource" createVehicleLocal getpos _tank;
_sm setParticleRandom [0.5, [0.3, 0.3, 0.3], [0.5, 0.5, 0.5], 0, 0.3, [0, 0, 0, 0], 0, 0,360];
_sm setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 8,10],
"false", "Billboard", 1, 5, [0, 0, 0],
[0,0,0], 1, 1.2, 1, 0.5, [2,4],
[[0.2,0.2,0.2,0.8], [1,1,1,0.3], [1,1,1,0]],[1],0.1,0.1,"","",_tank];
_sm setdropinterval 0.08;

sleep (7+(random 10));
deleteVehicle _sm;
 
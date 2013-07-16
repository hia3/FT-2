class CfgSounds
{
	class area_capture_all
	{
		name="area_capture_all";
		sound[]={"sound\area_capture_all.ogg",db+2,1.0};
		titles[]={};
	};
	class mhq_down
	{
		name="mhq_down";
		sound[]={"sound\mhq_down.ogg",db+1,1.0};
		titles[]={};
	};
	class area_capture_far
	{
		name="area_capture_far";
		sound[]={"sound\area_capture_far.ogg",db+1,1.0};
		titles[]={};
	};
	class error_sound
	{
		name="error_sound";
		sound[]={"sound\error.ogg",db-3,1.0};
		titles[]={};
	};
	class tip_sound
	{
		name="tip_sound";
		sound[]={"sound\tip.ogg",db-32,1.0};
		titles[]={};
	};
	class hint_sound
	{
		name="hint_sound";
		sound[]={"sound\hint.ogg",db-10,1.0};
		titles[]={};
	};
	class area_draw
	{
		name="area_draw";
		sound[]={"sound\area_draw.ogg",db+1,1};
		titles[]={};
	};
	class area_capture
	{
		name="area_capture";
		sound[]={"sound\area_capture.ogg",db+1,1};
		titles[]={};
	};

	class tank_alarm
	{
		name="tank_alarm";
		sound[]={"sound\tank_alarm.ogg",db+10,1};
		titles[]={};
	};
	class air_alarm
	{
		name="air_alarm";
		sound[]={"A3\Sounds_F\air\Mi48\alarm.wss",db+10,1};
		titles[]={};
	};

	class deafness
	{
		name="deafness";
		sound[]={"sound\deafness.ogg",db+10,1};
		titles[]={};
	};
	class grenade_explo_say
	{
		name="grenade_explo_say";
		sound[]={"sound\grenade_explo.ogg",db+5,1};
		titles[]={};
	};
};
class CfgRadio
{
	sounds[] = {tank_alarm, air_alarm, grenade_explo, grenade_in_tank};
	class tank_alarm
	{
		name = "tank_alarm";
		sound[] = {"sound\tank_alarm.ogg", db+1, 1.0};
		title = "";
	};
	class air_alarm
	{
		name = "air_alarm";
		sound[] = {"A3\Sounds_F\air\Mi48\alarm", db-2, db+1};
		title = "";
	};
	class grenade_explo
	{
		name = "grenade_explo";
		sound[] = {"sound\grenade_explo.ogg", db-2, db+1}; // .wss implied
		title = "";
	};
	class grenade_in_tank
	{
		name = "grenade_in_tank";
		sound[] = {"sound\grenade_in_tank.ogg", db-2, db+1}; // .wss implied
		title = "";
	};
};


class CfgMusic
{
	class IntroM
	{
		name="IntroM";
		sound[]={"sound\Intro.ogg", db-3, 1.0};
	};

	class OutroM
	{
		name="OutroM";
		sound[]={"sound\Outro.ogg", db-3, 1.0};
	};

	class AuxDosimeter
	{
		name="AuxDosimeter";
		sound[]={"sound_aux\dosimeter.ogg", db-3, 1.0};
	};
};

waitUntil{!(isNil "Public_TeamSpeakInfo")};

if (Public_TeamSpeakInfo == "") then
{
	Local_TS_host="hia3.net";
	Local_TS_port="9987";

	Local_TS_description="Regular";

	Local_TS_home="http://hia3.com";
	Local_TS_mail="contact@hia3.com";
}
else
{
	_ts_info=call compile Public_TeamSpeakInfo; // returns [host,port,description,home,mail]

	Local_TS_host=_ts_info select 0;
	Local_TS_port=_ts_info select 1;

	Local_TS_description=_ts_info select 2;

	Local_TS_home=_ts_info select 3;
	Local_TS_mail=_ts_info select 4;
};

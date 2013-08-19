//function increases player funds once a minute

if (((floor (time mod 60))==0) && (Local_LastIncomeTime<time)) then 
{
	//time step not to add income twice, because main thread period is 0.5s
	Local_LastIncomeTime=time+5;
	//increase funds
	Config_PeriodicIncome call Func_Client_ChangePlayerFunds;
};

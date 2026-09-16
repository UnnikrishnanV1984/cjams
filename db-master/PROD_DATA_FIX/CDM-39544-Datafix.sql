/*
   Issue Description: CDM-39544
   Category/ Module  : Remove living arrangement
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/

update
	placement
set
	activeflag = 0,
	updatedby = 'CDM-39544',
	updatedon = now()
where
	placementid = 'f5af3562-09dc-4772-a81d-084946231c81'
	and activeflag = 1;

update
	livingarrangement
set
	activeflag = 0,
	updatedby = 'CDM-39544',
	updatedon = now()
where
	placementid = 'f5af3562-09dc-4772-a81d-084946231c81'
	and activeflag = 1;

update 
	routing
set
	activeflag=0,
	updatedby = 'CDM-39544',
	updatedon = now()	
where 
	 objectid = 'f5af3562-09dc-4772-a81d-084946231c81'
	and eventcode = 'PLTR' and activeflag = 1;

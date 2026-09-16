/*
   Issue Description: CDM-39590
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
	updatedby = 'CDM-39590',
	updatedon = now()
where
	placementid = 'ffcf97e0-b1f3-4888-b258-86b86a78dc6b'
	and activeflag = 1;

update
	livingarrangement
set
	activeflag = 0,
	updatedby = 'CDM-39590',
	updatedon = now()
where
	placementid = 'ffcf97e0-b1f3-4888-b258-86b86a78dc6b'
	and activeflag = 1;
	
update 
	routing
set
	activeflag=0,
	updatedby = 'CDM-39590',
	updatedon = now()	
where 
	 objectid = 'ffcf97e0-b1f3-4888-b258-86b86a78dc6b'
	and eventcode = 'PLTR' and activeflag = 1;

update
	placementrevision
set
	activeflag = 0,
	updatedby = 'CDM-39590',
	updatedon = now()
where
	placementid = 'ffcf97e0-b1f3-4888-b258-86b86a78dc6b'
	and activeflag = 1;
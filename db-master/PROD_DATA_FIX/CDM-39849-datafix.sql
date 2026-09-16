/*
  Issue Description:  CDM-39849
   Category/ Module  :  Application
   Root cause: user requested to remove Relative/fictive kin home Living Arrangement
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/


UPDATE cjams.placement
SET activeflag=0, updatedby='CDM-39849', updatedon=now() 
WHERE placementid in ('fd974c00-e9ab-4815-828f-063e6a0bb4e4','57c7216d-2951-4aa1-bae3-0c25dc16efb6') and activeflag =1;

UPDATE cjams.placementrevision
SET activeflag=0, updatedby='CDM-39849', updatedon=now() 
WHERE placementid in ('fd974c00-e9ab-4815-828f-063e6a0bb4e4','57c7216d-2951-4aa1-bae3-0c25dc16efb6') and activeflag =1;

update livingarrangement 
set activeflag = 0,
	updatedby = 'CDM-39849',
	updatedon = now()
where placementid in ('fd974c00-e9ab-4815-828f-063e6a0bb4e4','57c7216d-2951-4aa1-bae3-0c25dc16efb6')
	and activeflag = 1 ;

update routing 
set activeflag = 0,
	updatedby = 'CDM-39849',
	updatedon = now()
where objectid in ('fd974c00-e9ab-4815-828f-063e6a0bb4e4','57c7216d-2951-4aa1-bae3-0c25dc16efb6')
	and eventcode = 'PLTR'
	and activeflag = 1 ;
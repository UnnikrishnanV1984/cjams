/*
   Issue Description: CDM-26037
   Category/ Module  :  PAYMENT
   Root cause: user requeseted to update payment
   Pull request# for code fix: 
   Reason why no related code fix: 
*/


update cjams.permanencyplan 
set intakeservicerequestactorid = '66501272-e141-41b2-9a2a-42b4da02a856',
	updatedby = 'CDM-26037',
	updatedon = now()
where permanencyplanid = 'b23ef4fb-e8bf-4370-89b0-4462a3232844'
	and activeflag  = 1 ;
 
 
 update cjams.gapratesrevision
set approvaldate = now(),
	updatedby = 'CDM-26037',
	updatedon = now()
where gaprateid = '74e1b806-68c4-4b28-a4fd-a8ed0e89c351' ;
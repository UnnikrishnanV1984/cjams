/*
   Issue Description: CDM-23480
   Module: IntakeService Request
   Root cause: User request to remove these two persons from case # 221020231139

   Reason why no related code fix: User request to remove these two persons from case # 221020231139
   Status of the code fix if already submitted and expected prod fix date: 
*/

update 	cjams.actor 
set 	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-23480'
where 	intakeserviceid = 'e5d7ab25-1b70-4eee-832d-062cddad7825' 
		and personid in ('3537533b-a8ba-423c-94bf-fe8f231fc937', '1768950f-2db0-4bad-af70-8cbff7500c35')
		and activeflag = 1;

update 	cjams.intakeservicerequestactor
set 	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-23480'
where 	personid in ('3537533b-a8ba-423c-94bf-fe8f231fc937', '1768950f-2db0-4bad-af70-8cbff7500c35')
        and intakeserviceid = 'e5d7ab25-1b70-4eee-832d-062cddad7825' 
        and activeflag = 1;


update 	cjams.personrole
set 	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-23480'
where 	personid in ('3537533b-a8ba-423c-94bf-fe8f231fc937', '1768950f-2db0-4bad-af70-8cbff7500c35') 
        and intakeserviceid = 'e5d7ab25-1b70-4eee-832d-062cddad7825' 
        and activeflag = 1;


update 	cjams.actorrelationship  
set 	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-23480'
where 	activeflag = 1 
		and intakeserviceid = 'e5d7ab25-1b70-4eee-832d-062cddad7825' 
        and intakeservicerequestactorid in 
        (   
select i.intakeservicerequestactorid
from    intakeservicerequestactor i 
where   i.personid  in ('3537533b-a8ba-423c-94bf-fe8f231fc937', '1768950f-2db0-4bad-af70-8cbff7500c35')
        and i.intakeserviceid = 'e5d7ab25-1b70-4eee-832d-062cddad7825' )

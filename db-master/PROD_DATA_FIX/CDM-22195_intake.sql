 /*
  Issue Description: CDM-22195 Case closure
   Category/ Module  :  Intake
   Root cause:
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/

select * from servicerequesttypeconfigdispositioncode where insertedby ='CDM-22195'
and servicerequesttypeconfigiddispostionid='b78b90b3-f3a0-438b-b7c8-931569feb499';

update servicerequesttypeconfigdispositioncode set activeflag=0, updatedby='CDM-22195', updatedon=now() where insertedby ='CDM-22195'
and servicerequesttypeconfigiddispostionid='b78b90b3-f3a0-438b-b7c8-931569feb499';


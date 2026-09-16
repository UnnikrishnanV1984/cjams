/*
 Issue Description:CDM-41771
 Category/ Module:Intake
 Root cause: user requested to delete intake
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/




update routing 
set activeflag=0,updatedon=now(),updatedby='CDM-41771'
where objectid ='I202000413035' and activeflag=1;

update intakedastatus 
set activeflag=0,updatedon=now(),updatedby='CDM-41771'
where intakenumber ='I202000413035' and activeflag=1;

update intakedastaging 
set activeflag=0,updatedon=now(),updatedby='CDM-41771'
where intakenumber ='I202000413035' and activeflag=1;

update intakesnapshot 
set activeflag=0,updatedon=now(),updatedby='CDM-41771'
where intakenumber ='I202000413035' and activeflag=1;
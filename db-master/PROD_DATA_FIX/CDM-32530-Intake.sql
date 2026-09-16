/*
   Issue Description: CDM-32530
   Category/ Module  : Delete intake
   Root cause: user wants to delete this  intakes
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-32530'
where intakenumber in ('I221010320280','I231010519417') and activeflag=1;

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-32530'
where intakenumber in ('I221010320280','I231010519417') and activeflag=1;

-- Checked Routing, intakesnapshot, intakeservicerequest no records found
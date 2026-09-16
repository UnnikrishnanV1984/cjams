/*
   Issue Description: CDM-36694 / I211010166491: Case opened in error-the case record is blank.
   Category/ Module: Removing intake
   Root cause: Validated and the Intake has no detail information in it. 
   		Hence removing the Intake # I211010166491 as requested.
*/

update routing
set activeflag = 0, updatedon = now(), updatedby = 'CDM-36994'
where objectid = 'I211010166491';

update intakedastatus
set activeflag = 0, updatedon = now(), updatedby = 'CDM-36994'
where intakenumber = 'I211010166491';

update intakedastaging
set activeflag = 0, updatedon = now(), updatedby = 'CDM-36994'
where intakenumber = 'I211010166491';

update intakesnapshot
set activeflag = 0, updatedon = now(), updatedby = 'CDM-36994'
where intakenumber = 'I211010166491';

update intakeservicerequest 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-36994'
where intakenumber = 'I211010166491';

update intakeservicerequestactor 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-36994'
where intakenumber = 'I211010166491';
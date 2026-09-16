/*
   Issue Description: CDM-36988 / I211010212873: Case opened in error-the case record is blank.
   Category/ Module: Removing intake
   Root Cause: Validated and the Intake has no detail information in it. 
   	       Hence removing the Intake # I211010212873 as requested.
*/

update routing 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-36988' 
where objectid = 'I211010212873';

update intakedastatus 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-36988' 
where intakenumber = 'I211010212873';

update intakedastaging 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-36988' 
where intakenumber = 'I211010212873';

update intakesnapshot 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-36988' 
where intakenumber = 'I211010212873';

update intakeservicerequest 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-36988' 
where intakenumber = 'I211010212873';

update intakeservicerequestactor 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-36988'
where intakenumber = 'I211010212873';

update actor  
set activeflag = 0, updatedon = now(), updatedby = 'CDM-36988' 
where actorid = '2919a5ac-0871-4de5-94d9-ba4a770882fe' and intakenumber = 'I211010212873';

update personrole 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-36988' 
where personid = '76dcef78-b41e-4772-bf01-0291af91ad00' and intakenumber = 'I211010212873';

update personroletype 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-36988' 
where personroleid = '7e6f07ba-d7cb-4bad-bb0d-5150cb054319';

update actorrelationship 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-36988' 
where actorrelationshipid = '328d4836-c930-4a50-adc7-59d74e3a8620' and intakenumber = 'I211010212873';
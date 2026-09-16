/*
   Issue Description: CJAMS-61049
   Category/ Module  : delete intake 
   Root cause: User wants to delete intake
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Intake is still in progress status and has not been submitted for supervisor approval. Need to do data fix
*/

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-61049'
where intakenumber = 'I251013324025'and activeflag=1;

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-61049'
where intakenumber = 'I251013324025' and activeflag=1;

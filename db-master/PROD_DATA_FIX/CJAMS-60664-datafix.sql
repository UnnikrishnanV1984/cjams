/*
   Issue Description: CJAMS-60664
        Delete
   Category/ Module  : Intake removal
   Root cause:  Data fix to remove the intake (I251013301029) 
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakedastatus
set activeflag=0, updatedby='CJAMS-60664', updatedon=now()
where intakenumber='I251013301029';

update intakedastaging
set activeflag=0, updatedby='CJAMS-60664', updatedon=now()
where intakenumber='I251013301029';

/*
   Issue Description: CDM-36993
   Category/ Module  : Decision
   Root cause: User wants to remove delete Intake # I202100147087
   Resolution: Removed the intake # I202100147087 as requeste by setting activeflag to 0.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
select * from intakedastaging where intakenumber = 'I202100147087' and activeflag=1;

update cjams.intakedastaging 
set activeflag = 0, updatedby = 'CDM-36993', updatedon = now() 
 where intakenumber = 'I202100147087' and activeflag=1;

select * from intakedastatus where intakenumber = 'I202100147087' and activeflag=1;

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-36993'
where intakenumber = 'I202100147087' and activeflag=1;

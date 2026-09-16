/*
 Issue Description: CDM-41518
 -- Category/ Module: Delete Intake referrals
 -- Root cause: User wants to remove the intake.
 -- Fix Provided: Datafix has been promoted to update the active flag.
 -- Pull request# N/A
 -- Reason why no related code fix: N/A
 -- Status of the code fix if already submitted and expected prod fix date: N/A
 */
update
    intakedastatus
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-41518'
where
    intakenumber = 'I241013132043'
    and activeflag = 1;

update
    intakedastaging
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-41518'
where
    intakenumber = 'I241013132043'
    and activeflag = 1;

update
    intakedastatus
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-41518'
where
    intakenumber = 'I241013131518'
    and activeflag = 1;

update
    intakedastaging
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-41518'
where
    intakenumber = 'I241013131518'
    and activeflag = 1;
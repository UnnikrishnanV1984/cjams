/*
 Issue Description:  CDM-42961-Intake-Approval-Glitch
 Category/ Module: Approval Dashboard
 Root cause: User request to change the intake status to screen out
 Pull request# for code fix: NA
 Reason why no related code fix: For screening out from dashboard from CJAMS data fix is needed
 Status of the code fix if already submitted and expected prod fix date: NO
 Backup before update/ delete: NA
 */
update
    intakeservicerequest
set
    activeflag = 0,
    updatedby = 'CDM-42961',
    updatedon = now()
where
    intakenumber = 'I241013182681'
    and activeflag = 1;

update
    intakeDAStatus
set
    status = 8,
    updatedby = 'CDM-42961',
    updatedon = now()
where
    intakenumber = 'I241013182681'
    and activeflag = 1;
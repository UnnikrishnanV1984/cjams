
/*
Issue: Mandate time wrong
Category/Module: CPS Intake
Root cause: The start date and mandate time was wrong and it must be updated to exactly 24 hours after the start date.
Fix provided: Data fix provided to stop the response timer.
Data/Code fix ticket#: CJAMS-66162
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: user error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
select * from intakeservicerequest where intakeserviceid = 'fafc4fca-a759-4f46-936b-dd45b6c2db33' and activeflag = 1;
*/
update intakeservicerequest set reporteddate='2026-03-06 12:21:00', updatedby = 'CJAMS-66162',
updatedon = now() where intakeserviceid  = 'fafc4fca-a759-4f46-936b-dd45b6c2db33';


update cjams.cpsresponsetimeractions
    set activeflag = 0, 
        updatedby = 'CJAMS-66162',
        updatedon = now()
where intakeserviceid  = 'fafc4fca-a759-4f46-936b-dd45b6c2db33'  and activeflag = 1;

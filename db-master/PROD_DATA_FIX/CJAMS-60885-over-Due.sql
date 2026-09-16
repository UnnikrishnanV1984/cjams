/*
Issue Description:251023081002:Unable to submit (resubmit) CJAMS timer overdue reason (previously submitted to supervisor and approved on 6/23/25), however need to resubmit due to dropdown for contact with alleged victim being left blank. Screen
Root cause: Incorrect response reason was selected due to a dropdown misselection during entry, leading to an inaccurate mandate violation.
Fix provided: Data fix has been done to update the cpsresponsetimeractions table.
Data/Code fix ticket#: CJAMS-60885
Regression Impacts: N/A
Is Code fix Required?: yes
Code fix ticket#:CIDM-10467
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
--72b7ea32-edae-437a-8d41-8bdfa4dce775
update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VWCR', cpsresponsetimerreason2 = '["VSSR"]', updatedby = 'CJAMS-60885',updatedon = now()
where activeflag = 1 and cpsresponsetimeractionsid in ('6f4911e7-ad3a-46e0-8f8c-af3dde10f1f2');
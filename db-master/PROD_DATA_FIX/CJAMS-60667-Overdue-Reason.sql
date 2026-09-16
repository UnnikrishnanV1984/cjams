
/*
Issue Description:251023059875:Over Due Reason - Late/Missing Reporting info disappeared and is showing as Missing in reports, though the dropdown was completed and approved 5/28/25. For alleged victim, the drop down should show:Alleged Victim UnavailableAttempted F2F1-2 Attempts.
Root cause: Incorrect response reason was selected due to a dropdown misselection during entry, leading to an inaccurate mandate violation.
Fix provided: Data fix has been done to update the cpsresponsetimeractions table.
Data/Code fix ticket#: CJAMS-60667
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a one-off user entry error; application logic and dropdown options are functioning correctly. A data fix was sufficient to correct the reason values.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
--72b7ea32-edae-437a-8d41-8bdfa4dce775
update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VAVU', cpsresponsetimerreason2 = 'VAFF', cpsresponsetimerreason3 = 'V12F',updatedby = 'CJAMS-60667',updatedon = now()
where activeflag = 1 and cpsresponsetimeractionsid in ('6627e487-dde5-4709-bc85-c0c09056ace4','72b7ea32-edae-437a-8d41-8bdfa4dce775');

/*
Issue Description:251023044810:The wrong option was chosen for the reason for late/missed visit for the child. Please change to the following choice: Contact With Alleged Victim Completed - - attempted face to face -> 1-2 attempts 
Root cause: Incorrect response reason was selected due to a dropdown misselection during entry, leading to an inaccurate mandate violation.
Fix provided: Data fix has been done to update the cpsresponsetimeractions table.
Data/Code fix ticket#: CJAMS-60658
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a one-off user entry error; application logic and dropdown options are functioning correctly. A data fix was sufficient to correct the reason values.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
--72b7ea32-edae-437a-8d41-8bdfa4dce775
update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VAVU', cpsresponsetimerreason2 = 'VAFF', cpsresponsetimerreason3 = 'V12F',updatedby = 'CJAMS-60658',updatedon = now()
where activeflag = 1 and cpsresponsetimeractionsid in ('7b3a6407-8c01-45f3-b113-7483225a297b','24172dd6-4a1d-43bf-909e-804f2083ccc0');
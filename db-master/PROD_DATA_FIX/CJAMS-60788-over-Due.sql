/*
Issue Description:251023064387:The worker did not select the correct drop down and the correct drop down should be "the alleged victim was unavailable"
Root cause: Incorrect response reason was selected due to a dropdown misselection during entry, leading to an inaccurate mandate violation.
Fix provided: Data fix has been done to update the cpsresponsetimeractions table.
Data/Code fix ticket#: CJAMS-60788
Regression Impacts: N/A
Is Code fix Required?: yes
Code fix ticket#:CIDM-10467
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
--72b7ea32-edae-437a-8d41-8bdfa4dce775
update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VAVU', cpsresponsetimerreason2 = 'VFCM', updatedby = 'CJAMS-60788',updatedon = now()
where activeflag = 1 and cpsresponsetimeractionsid in ('2498ecb6-a958-4088-b682-f0db471781b0');
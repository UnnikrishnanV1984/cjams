/*
Issue Description:251023096415:Please revised reason in drop down to: "AV unavailable - Family was contacted but unable to meet within the mandate
Root cause: Incorrect response reason was selected due to a dropdown misselection during entry, leading to an inaccurate mandate violation.
Fix provided: Data fix has been done to update the cpsresponsetimeractions table.
Data/Code fix ticket#: CJAMS-62050
Regression Impacts: N/A
Is Code fix Required?: yes
Code fix ticket#:CIDM-10467
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
--e6f3524e-4f54-4c08-9057-d402f7a04795
update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VAVU', cpsresponsetimerreason2 = 'VFCM', updatedby = 'CJAMS-62050',updatedon = now()
where activeflag = 1 and cpsresponsetimeractionsid in ('e6f3524e-4f54-4c08-9057-d402f7a04795');
/*
Issue Description:251023126015:Late/Missing Reason for alleged victim needs correction. Correct dropdowns should show:Alleged victim unavailable > 5 or more attempts 
Root cause: Incorrect response reason was selected due to a dropdown misselection during entry, leading to an inaccurate mandate violation.
Fix provided: Data fix has been done to update the cpsresponsetimeractions table.
Data/Code fix ticket#: CJAMS-63175
Regression Impacts: N/A
Is Code fix Required?: yes 
Code fix ticket#:CIDM-10467 
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VAVU', cpsresponsetimerreason2 = 'VAFF', cpsresponsetimerreason3 ='V34F', updatedby = 'CJAMS-63175',updatedon = now()
where activeflag = 1 and cpsresponsetimeractionsid in ('d66297c7-492b-4a9e-8a63-205264d09505');
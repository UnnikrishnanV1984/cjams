
/*
Issue Description:251023126015:Late/Missing Reason for alleged victim needs correction. Correct dropdowns should show:Alleged victim unavailable > 5 or more attempts 
Root cause: Incorrect response reason was selected due to a dropdown misselection during entry, leading to an inaccurate mandate violation.
Fix provided: Data fix has been done to update the cpsresponsetimeractions table.
Data/Code fix ticket#: CJAMS-62639
Regression Impacts: N/A
Is Code fix Required?: yes
Code fix ticket#:CIDM-10467
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VAVU', cpsresponsetimerreason2 = 'VAFF', cpsresponsetimerreason3 ='V5MF', updatedby = 'CJAMS-62639',updatedon = now()
where activeflag = 1 and cpsresponsetimeractionsid in ('afadced3-5947-4387-a400-da4c1fde117c','64fec375-20af-4991-8cde-f96e5819ade1');
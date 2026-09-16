/*
Issue Description:3271644:Please delete the duplicate Living Arrangement that is in Review. I've also posted it below. 3271644Living ArrangementRespite care929 Fawn Ave , Pasadena , Maryland , 2112205/30/2025 04:30 PMReview 
Category/Module: Bug
Root cause: User created duplciated LA record, User do not have chance to delete the record.
Fix provided: DB queries  update intakedastatus, intakedastaging table.
Data/Code fix ticket#: CJAMS-60299
Regression Impacts: N/A
Is Code fix Required?: No      
Code fix ticket#: N/A
Reason why no related code fix: User Roor
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update placement
set activeflag = 0 , updatedby = 'CJAMS-60299', updatedon =now()
where placementid = '2835332a-5f1d-4283-bb71-8ee52f912271' and activeflag =1;


update placementrevision
set activeflag = 0, updatedby = 'CJAMS-60299', updatedon =now()
where placementrevisionid in ('4ddaafa7-5ac4-41e4-9365-fb50a59b8e03') and activeflag =1;

update livingarrangement
set activeflag = 0 , updatedby = 'CJAMS-60299', updatedon =now()
where livingid = 'a7ba72b9-4ca3-4f77-92e0-a852b38102dd' and activeflag =1;
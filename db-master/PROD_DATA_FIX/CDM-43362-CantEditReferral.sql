/*
Issue Description: The intake narrative is not populating the information and no Communication, Purpose and Author name listed correctly
Category/Module: Bug
Root cause: Data error caused the latest instance of intakedastaging to not save properly
Fix provided: DB query to deactivate the latest instance and activate the one before in intakedastaging
Data/Code fix ticket#: CDM-43362
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating intakedastaging
update intakedastaging
set activeflag = 0, updatedby = 'CDM-43362', updatedon = now()
where id = 11450848;

update intakedastaging
set activeflag = 1, updatedby = 'CDM-43362', updatedon = now()
where id = 11450846;
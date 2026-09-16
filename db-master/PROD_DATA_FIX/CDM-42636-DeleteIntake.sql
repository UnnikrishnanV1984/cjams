/*
Issue: Please delete the respective intake
Category/Module: Error
Root cause: User created this intake in error
Fix provided: DB queries to deactivate intake
Data/Code fix ticket#: CDM-42636
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--intakedastaging
update intakedastaging
set updatedon = now(), updatedby = 'CDM-42636' ,activeflag = 0
where intakenumber = 'I241013161186' and activeflag = 1;

--intakedastatus
update intakedastatus
set updatedon = now(), updatedby = 'CDM-42636' ,activeflag = 0
where intakenumber = 'I241013161186' and activeflag = 1;
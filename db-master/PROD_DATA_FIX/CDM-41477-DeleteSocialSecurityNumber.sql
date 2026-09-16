/*
Issue Description: Approval received, update to consumer has been verified to delete SSN
Category/Module: Support
Root cause: User requested to remove a person's SSN from records
Fix provided: DB queries to delete SSN from the person
Data/Code fix ticket#: CDM-41477
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating person
update person 
set ssnno = null, updatedby = 'CDM-41477', updatedon = now()
where personid = 'ea2dbd67-a5ae-4275-8280-4a9ea8ba50ce' and activeflag = 1;

--Updating personidentifier
update personidentifier
set personidentifiervalue = '', updatedby = 'CDM-41477', updatedon = now()
where personidentifierid = 'a549dc7b-0c96-4cf2-a8c0-7215a533a40d' and activeflag = 1;
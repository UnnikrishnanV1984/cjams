/*
Issue Description: We want a data fix as 08/27/2024 for both Agreement date and signed date.
Category/Module: Bug
Root cause: Signed date could only be as latest as current date
Fix provided: DB query to add signed date as 08/27/2024
Data/Code fix ticket#:CDM-41384
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating serviceagreementlist
update serviceagreementlist 
set signeddate = '2024-08-27 00:00:00.000', updatedby = 'CDM-41384', updatedon = now()
where serviceagreementid = 'a73f5ca9-6e48-4636-a760-d3cd83cc210b';
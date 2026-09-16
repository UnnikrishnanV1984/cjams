/*
Issue Description:251030483666:The living arrangement is duplicated. Please void the entry that was "rejected" by the supervisor. 
Root cause: User request to delete LA record due to they do not have access to delete.
Fix provided: DB query to udate placement,livingarrangement.
Data/Code fix ticket#:CJAMS-61899
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#:  no
Reason why no related code fix:User error, not logic error.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update placement
set activeflag = 0, updatedby ='CJAMS-61899',updatedon=now()
where placementid ='7f6bb44d-ba5f-409e-9d22-8194238d9582' and activeflag=1;

update livingarrangement
set activeflag = 0, updatedby ='CJAMS-61899',updatedon=now()
where livingid ='4f30ce9b-7d50-4c0e-a8c2-40b0b520de08' and activeflag=1;


update  routing
set activeflag = 0, updatedby ='CJAMS-61899',updatedon=now()
where routingid ='bae7d5be-2303-4148-838d-3823015a4bab' and activeflag=1;

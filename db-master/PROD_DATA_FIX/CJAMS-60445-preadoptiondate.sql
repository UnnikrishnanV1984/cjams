/*
Issue Description: The individual I am attempting to clear was previously adopted. The system will not allow me to add this person to the clearance without adding their adoption date
Root cause: This is a migrated data and the previous adoption date is missing which is not allowing to add the client to an Intake/Case.
Fix provided: DB queries to update query to person table
Data/Code fix ticket#: CJAMS-60445
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: not functional issue, only data related issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update person 
set preadoptiondate = '2008-02-06',updatedby = 'CJAMS-60445', updatedon = NOW()
where personid = '4a367c2b-eae3-4353-bd41-769de4f94d78' and activeflag=1;
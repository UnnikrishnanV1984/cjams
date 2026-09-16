/*
Issue Description: The individual I am attempting to clear was previously adopted. The system will not allow me to add this person to the clearance without adding their adoption date
Root cause: This is a migrated data and the previous adoption date is missing which is not allowing to add the client to an Intake/Case.
Fix provided: DB queries to update query to person table
Data/Code fix ticket#: CJAMS-60286
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: not functional issue, only data related issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update person 
set everbeenadoptedflag = 1,preadoptiondate = '2002-05-12',updatedby = 'CJAMS-60286', updatedon = NOW()
where personid = '21679a61-9436-49ca-b8a4-8ba9989a1e3e' and activeflag=1;
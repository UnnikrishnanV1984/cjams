/*
Issue Description: Investigation Finding
Root cause: Update the correct allegationId to the correct sexual abuse value, now panel renders correctly and we can see the records on the Investigation findings tab.
Fix provided: DB query to update the correct allegationId to the correct sexual abuse value, now panel renders correctly and we can see the records on the Investigation findings tab.
Data/Code fix ticket#: CJAMS-68703
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
update investigationallegation
set allegationid = '19233c90-707c-482c-93c8-b33738685fc6',
    updatedby = 'CJAMS-68703',
    updatedon = now()
where investigationallegationid='ed8d388b-4b57-4e27-9dff-04b29edb719d' and allegationid='627b574e-aa98-48c1-98c3-cf6f5d155eff';
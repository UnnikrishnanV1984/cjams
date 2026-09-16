
/*
Root cause:
The case is closed on 07/29/2025 and user is requested to change the date of incident in the Maltreatment Allegation screen for both alleged maltreator from 06/27/2025 to 05/19/2025.
CPS IR #: 251023083618
Fix provided: DB queries  update investigationfinding tables
Data/Code fix ticket#: CJAMS-65670
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update investigationallegation
set incidentdate = '2025-05-19', updatedby = 'CJAMS-65670', updatedon = now()
where investigationallegationid in (
	'f6cef442-b80e-4a9f-ad12-5a6ab2fd1859','548a407f-fe65-4738-99a6-9f38b3bf3e55') and activeflag = 1;
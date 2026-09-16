/*
Issue Description: 
Category/ Module : Bug
Root cause:Case assignment end date.
Fix provided: Yes, write Db query 
Code fix ticket#: CDM-43881
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update caseassignment
set enddate='2025-01-21 09:22:46', updatedby='CDM-43881', updatedon= now()
where caseassignmentid='33f9a0a2-0b53-4a15-a1ba-590ac14511f8' and activeflag = 1;

/*
Issue Description: Please remove the intake as the user has created another intake and connected to existing service case.
Category/Module: Error
Root cause: Intake I241012789089 needs removal as the user has created another intake.
Fix provided: Yes, write Db query 
Code fix ticket#: CDM-40231
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating intake in intakeservicerequest
update intakeservicerequest
set activeflag = 0, updatedby = 'CDM-40231', updatedon = now()
where intakenumber = 'I241012789089' and activeflag = 1;

--Deactivating intake in intakesnapshot
update intakesnapshot 
set activeflag = 0, updatedby = 'CDM-40231', updatedon = now()
where intakenumber = 'I241012789089' and activeflag = 1;

--Deactivating intake in intakedastatus
update intakedastatus 
set activeflag = 0, updatedby = 'CDM-40231', updatedon = now()
where intakenumber = 'I241012789089' and activeflag = 1;

--Deactivating intake in intakedastaging
update intakedastaging 
set activeflag = 0, updatedby = 'CDM-40231', updatedon = now()
where intakenumber = 'I241012789089' and activeflag = 1;
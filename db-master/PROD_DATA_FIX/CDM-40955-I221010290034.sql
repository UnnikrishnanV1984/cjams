/*
Issue Description: Please delete the respective intake as requested
Category/Module: Bug
Root cause: Intake needs to be removed from extended hours.
Fix provided: DB query to remove the case from intakedastaging and intakedastatus
Code/Data fix ticket#: CDM-40955
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error. 
Backup before update/ delete:Query:
*/

--Deactivating the intake from intakedastaging
update intakedastaging
set activeflag = 0, updatedby = 'CDM-40955', updatedon = now()
where intakenumber = 'I221010290034' and activeflag = 1;

--Deactivating the intake from intakedastatus
update intakedastatus
set activeflag = 0, updatedby = 'CDM-40955', updatedon = now()
where intakenumber = 'I221010290034' and activeflag = 1;
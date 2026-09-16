/*
Issue Description: Intake user could not reject , but want to remove from assign tab and Intake should not be deleted from application
Category/Module: Bug
Root cause: Intake transfer history had one record with no user assigned
Fix provided: DB query to remove the faulty record from transfer history
Data/Code fix ticket#: CDM-41851
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating record from intaketransfers
update intaketransfers
set activeflag = 0, updatedby = 'CDM-41851', updatedon = now()
where intaketransferid = 'b60e09fd-2f1b-45a2-880a-df811ffcff94' and activeflag = 1;
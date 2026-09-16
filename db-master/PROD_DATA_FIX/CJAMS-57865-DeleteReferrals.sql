
/*
Issue Description: Please do a data fix to delete the intake # I251013227495 and set intake# I251013211786 as the source of SEN for cjams id - 203960157.
Category/Module: Error
Root cause: User created two intake referrals,and they do not have access to delete , two needs to be deleted.
Fix provided: DB queries to delete said referral.
Data/Code fix ticket#:CJAMS-57865
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

-------------Deactivating requested Intake--------------
--Deactivating in intakedastaging
update intakedastaging
set activeflag = 0, updatedby = 'CJAMS-57865', updatedon = now()
where intakenumber in ('I251013227495','I251013211786')  and activeflag = 1;

--Deactivating in intakedastatus
update intakedastatus
set activeflag = 0, updatedby = 'CJAMS-57865', updatedon = now()
where intakedastatusid in ('03ab3d93-9a8e-4c5a-a907-1a15187cc570','8295d332-7fa8-4209-985b-47cdecb9094b') and activeflag = 1;

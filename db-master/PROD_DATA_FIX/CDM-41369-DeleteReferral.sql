/*
Issue Description: Please do a data fix to delete the intake # I241013112823 and set intake# I241013117536 as the source of SEN for cjams id - 203960157.
Category/Module: Error
Root cause: User created two intake referrals, one needs to be deleted
Fix provided: DB queries to delete said referral and reactivate correct referral
Data/Code fix ticket#:CDM-41369
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
set activeflag = 0, updatedby = 'CDM-41369', updatedon = now()
where intakenumber = 'I241013112823' and activeflag = 1;

--Deactivating in intakedastatus
update intakedastatus
set activeflag = 0, updatedby = 'CDM-41369', updatedon = now()
where intakedastatusid = '941e2d38-92fb-4e0c-91e2-d723247be5ed' and activeflag = 1;

--Deactivating in intakesnapshot
update intakesnapshot
set activeflag = 0, updatedby = 'CDM-41369', updatedon = now()
where intakesnapshotid = '9398280d-7eea-447b-b9b5-a76a13aa9ab9' and activeflag = 1;

--Deactivating in intakeservicerequest
update intakeservicerequest
set activeflag = 0, updatedby = 'CDM-41369', updatedon = now()
where intakeserviceid = 'ed2c352c-0a62-4040-be75-a5e5c5ed676d' and activeflag = 1;

-------------Reactivating other Intake--------------
--Reactivating in intkeservicerequest
update intakeservicerequest
set activeflag = 0, updatedby = 'CDM-41369', updatedon = now()
where intakeserviceid = '909a8da5-b025-4260-9b55-9bcb16ddf9ae' and activeflag = 0;

-------------Changing referral for SEN in person--------------
update person
set substanceexposednewbornsourceid = 'I241013117536', updatedby = 'CDM-41369', updatedon = now()
where personid = '04b46249-188a-4ae8-8cd8-63b40283ec0f' and activeflag = 1;
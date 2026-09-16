
/*
Issue:Dashboard:Child was incorrectly listed as "Active Other" instead of "Active in Household"
Root Cause:System failed to recognize the correct household actor because of duplicate active records and missing household membership flag.
Fix Provided (Data Fix Only):Data fix was done by Updated actor with ralted tabbles.
Data/Code fix ticket#: CJAMS-60786
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: logic working fine, only data related issue.
Backup before update/ delete:Query:

*/

--deactivating duplicate entries
update actor
set activeflag = 0,updatedby = 'CJAMS-60786', updatedon = now()
where actorid = '6c0dc4f0-ef9e-42c4-80c4-ced06fb1f594' and activeflag = 1;

update intakeservicerequestactor
set activeflag = 0,updatedby = 'CJAMS-60786', updatedon = now()
where actorid = '6c0dc4f0-ef9e-42c4-80c4-ced06fb1f594' and activeflag = 1;

--Flagging household as true for child
update actor
set ishouseholdmember = 1,updatedby = 'CJAMS-60786', updatedon = now()
where actorid = '16a7c2f1-dc64-49fd-8e23-c66fb7584bbd' and activeflag = 1;

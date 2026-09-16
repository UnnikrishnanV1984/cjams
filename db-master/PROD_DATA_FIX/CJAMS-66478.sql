/*
Issue: CJAMS-66478 Back Payments
Category/Module: GAP
Root cause: With the March 1st payment batch run, we were unable to process the Adoption subsidy payment for Public Provider ID: 5095043 (Damika Ward).
           This error occurred because the provider category was recently updated to "ICPC Home Study" in CJAMS
Fix provided: Data fix has been done to trigger the missing payments for
             Montgomery County Case ID: 251040604946,Client ID: 204347415 (Tayvon Ward)
Data/Code fix ticket#: CJAMS-66478
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a due to missing information and data fix is done to trigger the payments batch.
*/




-- To Trigger Under/Over batch
update adoptioncaseagreementrate
set updatedby = 'CJAMS-66478',
    updatedon = now()
where adoptionagreementrateid = '86c91641-d744-4a80-9b41-b8d2be12ef9f'
    and activeflag = 1 ;
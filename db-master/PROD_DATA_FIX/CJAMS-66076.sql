
/*
Issue: CJAMS-66076 Decision tab case status should be open not closed
Root Cause: The case was reopened on 03/04/2025, and there is an information on the blue ribbon that the case closed on 04/15/2025.
Fix Provided: Fix provided to update the end date to null
Data/Code fix ticket#: CJAMS-66076
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue caused by system timeout.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
select * from tb_service_purchase_authorization where authorization_id in ('4237348','4237339','4237333','4237332','4237326','4237319') and delete_sw = 'N';
*/
  update cjams.servicecase
  set enddate = null, updatedby='CJAMS-66076', updatedon= now()
  where servicecaseid = '64c50a2e-64ef-4c1f-8e9c-43a4f82130b6';
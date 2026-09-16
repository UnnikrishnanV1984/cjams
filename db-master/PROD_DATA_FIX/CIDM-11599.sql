/*
Issue Description: CJAMS-69247 Approved Permanency Plan still appears in Approval Inbox
Category/Module: Permanency Plan / Approval Inbox
Root cause: The routing record for permanency plan carries the wrong servicerequestnumber (211030013178). The permanency plan is
            actually associated with Case ID 3003954. Because of this mismatch the record
            stays in the Approval Inbox of stacey.cochran@maryland.gov even though it has
            been approved.
Fix provided: Data fix to correct the routing servicerequestnumber to 3003954 so the record
              is tied to the correct case.
Regression Impacts: N/A
Is Code fix Required?: Yes- CDM-44888
Code fix ticket#: N/A
Reason why no related code fix: Data fix needed to correct the routing servicerequestnumber.
*/

update routing
set servicerequestnumber = '3003954',
    updatedby = 'CJAMS-69247',
    updatedon = now()
where routingid = 'f2c40e17-b616-4e98-9d0f-4a848fc3e06b' and activeflag = 1;
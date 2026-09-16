/*
Issue Description: CJAMS-58650: Data fix to approve tickets S2025084065532,S2025084065545
Category/Module: Contact Support
Root cause: The case workers default supervisor is michelle.reeve@maryland.gov deactivated from the sail point and this is causing issue with contact support ticket creation with jira ticket creation API.
            The external jira API is not creating the ticket when default supervisor is sent as null.
Fix provided: Data fix has been done to update case wokers default supervisor to Cortney Carey in the contact support table for approval and ticket creation flow to complete.
              Code fix has been done as the part of CIDM-10308 to handle the request when default supervisor is inactive.
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: CIDM-10308
Reason why no related code fix: N/A
*/

update defecttracking.supportlog
set caseworkerdefaultsupervisorid = 'e906f53d-4aaa-46a5-b61b-d6638825dce4',
    updatedby = 'CJAMS-58650',
    updatedon = now()
where supportno in ('S2025084065532','S2025084065545'); 
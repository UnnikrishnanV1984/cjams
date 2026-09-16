/*
Issue Description: CIDM-10138: Data fix to approve tickets S2025058065011,S2025077065378,S2025079065442
Category/Module: Contact Support
Root cause: The case workers default supervisor is clare.spillane@maryland.gov deactivated from the sail point and this is causing issue with contact support ticket creation with jira ticket creation API.
            The external jira API is not creating the ticket when default supervisor is sent as null.
Fix provided: Data fix has been done to update case wokers default supervisor to jenifer.dubosq@maryland.gov in the contact support table for approval and ticket creation flow to complete.
              Code fix has been done as the part of CIDM-10308 to handle the request when default supervisor is inactive.
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: CIDM-10308
Reason why no related code fix: N/A
*/

update defecttracking.supportlog
set caseworkerdefaultsupervisorid = '82f5d82d-7a9c-4dd9-9d48-eb9683acca2d',
    updatedby = 'CIDM-10318',
    updatedon = now()
where supportno in ('S2025058065011','S2025077065378','S2025079065442');
/*
Issue Description: CIDM-10238: Contact Support Ticket - Data fix to update status
Category/Module: Contact Support
Root cause:There are some records created in the contact support related table where jirarequestsent is set to empty string instead of null even for the records where ticket is created
           Need Data Fix to update all the Contact Support Tickets that are in Pending status to Approved status 
           This has happend due incorrect exception handling from server code and also empty records inserted from batch.
Fix provided: Data fix has been done to update jirarequestsent to approved when a corresponding jira ticket is created
Data/Code fix ticket#: CIDM-10238
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: CIDM-10237 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:

*/


update defecttracking.supportlog 
set jirarequestsent = 'Approved',
    updatedby = 'CIDM-10238',
    updatedon = now()
where jirarequestsent = '' and jirarequestno is not null; 
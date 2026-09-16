/*
Issue Description: CIDM-10823 Psychotropic secondary review null issue
Category/Module: Person Profile
Root cause:  Psychotropic report with request id 201 not coming up in the reports as all the routing records are inactive due to the data glitch.
             Data fix needs to be done to update the latest routing record to active.
Fix provided: Data fix has been done to update the latest routing record to active for the Request Id 201.
Data/Code fix ticket#: CIDM-10823
Regression Impacts: N/A
Is Code fix Required?: N/A
Code fix ticket#: N/A
Reason why no related code fix: This is a data glitch which in not reproducible and QA will be trying to replicate this scenario. 
*/

update routing
set activeflag = 1,
    updatedon = now(),
    updatedby = 'CIDM-10823'
where routingid = 'ba7dfb08-a525-448b-a423-d09fd6a7e698'
and   objectid = '7dc4f82d-93ca-48b0-9556-a66748f78fff';   
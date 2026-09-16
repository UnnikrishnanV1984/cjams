/*
   Issue Description: CDM-44012 Case Connect Issue
   Category/ Module  : Approval
   Root cause: User requested to remove the case from approval dashboard as it is no longer needed.
   Fix Provided: Data fix has been done to remove the review record from supervisor dashboard
   Data/Code fix ticket#: CDM-44012
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: This issue required data fix as this is a user error.
   Status of the code fix if already submitted and expected prod fix date: N/A  
*/

update routing set activeflag=0, updatedby = 'CDM-44012', updatedon = now()
where routingid = 'c5460fb6-7a16-4598-86f0-d3f5ca43db6f' and objectid = '2a161d82-3214-4dcc-a8c4-70756355491c';
/*
Issue Description:CJAMS-61924 GAP Agreements
Category/Module: GAP
Root cause: Incorrect supervisor name shown in the agreement approval as the user primary role is LDSS supervisor instead of CWSP.
            As per the code in the system we are displaying the supervisor name if he has CWSP role.
            Angela Edges is the supervisor who has previously approved this gap agreement and is shown in the DB.
Fix provided: Data fix has been provided to update the routing records entry to CWSP to display Crystal's name.          
Data/Code fix ticket#: 
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: TBD
Reason why no related code fix: N/A
*/

update routing
set fromroleid = 'CWSP',
    updatedon = now(),
    updatedby = 'CJAMS-61924'
where routingid='bd171edd-32b3-4892-87f2-7a15453f2428';
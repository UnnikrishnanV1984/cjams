/*
Issue: CJAMS-64582 can't assign intake
Category/Module: Intake /Decision
Root cause: Supervisor was unable to approve the intake as there is incorrect information inserted in the routing table when case worker sent it for review.
            We tried to replicate the Request for Services flow in stage-3 and it looks good. We will closely monitor this issue for future occurence.
Fix provided: Data fix to correct the pending routing record for the approval flow to work correctly  
Data/Code fix ticket#: CJAMS-64582
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix:  We tried to replicate the Request for Services flow in stage-3 and it looks good. We will closely monitor this issue for future occurence.
*/

update routing
set eventcode = 'INTR',
    activeflag =1,
    updatedby = 'CJAMS-64582',
    updatedon = now()
where routingid = '53581d46-9d7b-48cb-9b37-e6e6bfd0eff0'
and objectid = 'I261013724650'
and activeflag = 0;

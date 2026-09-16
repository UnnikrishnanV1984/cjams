/*
Issue Description: CJAMS-60442 Guardianship 3149486:Case 3149486 - Trinity Jones. Supervisor is unable to approve the review and guardian is not able to receive their benefits.
Category/Module: GAP Subsidy
Root cause: The Supervisor is not able to view the routing records in dashboard as incorrect role is assigned to the caseworker lisa.delee
            Code fix was done to resolve this issue and this issue happend before the code fix.
            Data fix needs to be done to resolve it.
Fix provided: Data fix has been done to update the roles and also make subsidy record available in the supervisor dashboard
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix:It was a known sailpoint issue related to beacon user story and it was resolved in last release.
*/
 --Fixing the role issue
update teammember
set roletypekey = 'CWCW',
    updatedon = now(),
    updatedby = 'CJAMS-60442'
where teammemberid='36085ded-7adf-4635-8b5e-3666ad0e7894'
and activeflag = 1;


-- Correcting the subsidy agreement related records in routing and other tables

update gapagreementrate
set status = 'Review',
    updatedon = now(),
    updatedby = 'CJAMS-60442'
where gapagreementrateid = '462c7a47-d864-4ca2-8572-cce3a6ef2f93'
and activeflag =1;


update routing
set activeflag = 1,
    fromroleid = 'CWCW',
    updatedon = now(),
    updatedby = 'CJAMS-60442'
where objectid='462c7a47-d864-4ca2-8572-cce3a6ef2f93'
      and routingid = '57a4246d-25fb-42cb-a2b0-916ecb39006b'
      and activeflag=0;


      
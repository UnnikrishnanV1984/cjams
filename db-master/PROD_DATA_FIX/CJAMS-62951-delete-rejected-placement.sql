/*
Issue:CJAMS-62951 placement issue .
Category/Module: Placement
Root cause: Placement  was created by mistake and data fix needed to delete it as requested by the user.
Fix provided: Data fix has been done to correct the placement that is rejected for 
              Case ID: 3178890
              Client ID: 3462859 (BYLANA HAYES)
Data/Code fix ticket#: CJAMS-62951
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User entry error and data fix should resolve it.
*/

update placement
set activeflag = 0,
    updatedby = 'CJAMS-62951',
    updatedon = now()
where placementid='71dac613-c8da-438b-a728-9fb498f7ab38';



update placementrevision
set activeflag = 0,
    updatedby = 'CJAMS-62951',
    updatedon = now()
where placementid='71dac613-c8da-438b-a728-9fb498f7ab38';


update routing
set activeflag = 0,
    updatedby = 'CJAMS-62951',
    updatedon = now()
where routingid = '19eee831-e0ad-4c25-a1bf-038701f26207'    
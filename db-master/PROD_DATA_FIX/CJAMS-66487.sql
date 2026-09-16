/*
Issue: CJAMS-66487-Assessment Glitch
Category/Module: GAP
Root cause: user error, user requested to remove the case from from Assessment pending approval inbox
Fix provided: Data fix has been done to remove the case from from Assessment pending approval inbox
Data/Code fix ticket#: CJAMS-66487
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix:
*/






update routing set activeflag=0,updatedby='CJAMS-66487',updatedon=now()
where routingid='93e434a1-6da2-4f8e-989d-868e4a957f7f' and activeflag=1;
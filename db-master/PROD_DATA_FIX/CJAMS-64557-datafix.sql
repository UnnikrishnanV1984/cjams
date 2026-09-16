/*
Issue Description: CJAMS-64557 Change perm plan date
Category/Module: Out-of-home
Root cause: User requested to update the perm plan date
Fix provided: Data fix has been promoted to update the perm plan date
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: The issue is specific to data and is not a recurring one or a logical issue.
*/

UPDATE permanencyplan 
SET establisheddate='2025-07-16', updatedon = NOW(), updatedby = 'CJAMS-64557'
WHERE permanencyplanid ='df74e24c-ae3c-419c-8398-17f8e6b97b9f'
AND activeflag = 1;

UPDATE permanencyplan 
SET activeflag=0, updatedon = NOW(), updatedby = 'CJAMS-64557'
WHERE permanencyplanid ='8723328a-ce1a-48f0-bd2c-a36111543885';

update routing
SET activeflag=0, updatedon = NOW(), updatedby = 'CJAMS-64557'
WHERE objectid = '8723328a-ce1a-48f0-bd2c-a36111543885'
and eventcode = 'PPLR';

update permanencyplan_history
SET activeflag=0, updatedon = NOW(), updatedby = 'CJAMS-64557'
WHERE permanencyplanid ='8723328a-ce1a-48f0-bd2c-a36111543885';
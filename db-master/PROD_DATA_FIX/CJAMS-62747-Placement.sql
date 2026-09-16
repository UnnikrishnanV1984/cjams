/*
Issue:3178890:3178890Provider PlacementSan Mar Children's Home Inc. TFC8504 Mapleville Rd Boonsboro Md 2171310/04/2019 08:52 PMRejected Is this able to be deleted. San mar is stating that it is showing up in their system, even though they are not getting a payment.
Root Cause:User requested to delete rejectd palcement.
Fix Provided (Data Fix Only):Update on placement,placementrevision tables.
Data/Code fix ticket#: CJAMS-62747
Regression Impacts:None 
Is Code fix Required?:yes
Code fix ticket#: no
Reason why no related code fix:User error
Backup before update/delete:
*/

update placement 
set activeflag  = 0, updatedby  ='CJAMS-62747', updatedon  = now()
where  placementid  ='4b357107-4e1f-4331-a747-fb59aa9dd8be' and activeflag  =1;


update placementrevision 
set activeflag  = 0, updatedby  ='CJAMS-62747', updatedon  = now()
where  placementrevisionid  ='66e03b4e-85bd-4a1b-a1ab-ea399bd81be4' and activeflag  =1;
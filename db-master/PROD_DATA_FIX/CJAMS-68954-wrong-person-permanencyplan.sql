/*
Category/Module: permanency plan
Root cause: User added wrong person into permanency plan.
Fix provided: As the person not linked to the case data fix to delete the person from the case by removing the servicecaseid
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: User error
*/

update permanencyplan 
set activeflag=0, updatedby ='CJAMS-68954', updatedon =now() 
where permanencyplanid ='70489842-132d-4715-87c5-036e622e857c' and activeflag =1;

update permanencyplan_history
set activeflag=0, updatedby ='CJAMS-68954', updatedon =now() 
where permanencyplanid ='70489842-132d-4715-87c5-036e622e857c' and activeflag =1;

update routing
set activeflag=0, updatedby ='CJAMS-68954', updatedon =now() 
where objectid ='70489842-132d-4715-87c5-036e622e857c' and eventcode = 'PPLR' and activeflag =1;

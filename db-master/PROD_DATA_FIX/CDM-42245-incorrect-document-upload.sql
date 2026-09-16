/*
 * CDM-42245
 * Description - user uploaded the wrong closing letter in a case and need to delete it.
 * case ID: 241022912042
 */

-- select * from documentproperties where documentpropertiesid = '90ed849c-7e37-4829-847a-2cb2dacaafdb';

update documentproperties 
set activeflag = 0, updatedby='CDM-42245', updatedon=now()
where documentpropertiesid = '90ed849c-7e37-4829-847a-2cb2dacaafdb' and activeflag=1;

-- select activeflag ,* from documentattachment where documentpropertiesid = '90ed849c-7e37-4829-847a-2cb2dacaafdb';

update documentattachment  
set activeflag = 0, updatedby='CDM-42245', updatedon=now()
where documentpropertiesid = '90ed849c-7e37-4829-847a-2cb2dacaafdb' and activeflag=1;
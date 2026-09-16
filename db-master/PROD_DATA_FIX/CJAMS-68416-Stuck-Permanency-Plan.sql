/*
   Issue Description:CJAMS-68416-Previous-approvals
      Category/ Module  :delete approval inbox
   Root cause: Please carry out data fix to remove the marked cases from Approval Inbox for permanency plan review records
   Fix Provided: Data fix to remove case from pending approval inbox
*/

update routing 
set 
	servicerequestnumber='3252827',
	updatedby = 'CJAMS-68416',
	updatedon = now()
where routingid in ('3582acfb-443f-4c02-a5f3-439f317ca339') and activeflag = 1;

update routing 
set 
	servicerequestnumber='3302996',
	updatedby = 'CJAMS-68416',
	updatedon = now()
where routingid in ('539a3ed2-2a68-41de-8469-69cb6b216f01') and activeflag = 1;

update routing 
set 
	servicerequestnumber='251030565357',
	updatedby = 'CJAMS-68416',
	updatedon = now()
where routingid in ('e2029e4e-03e8-4a9b-a989-2062c51b6181') and activeflag = 1;

update routing 
set 
	servicerequestnumber='3189677',
	updatedby = 'CJAMS-68416',
	updatedon = now()
where routingid in ('0d5257f4-c292-41db-aed6-451e806056ab') and activeflag = 1;

update routing 
set 
	servicerequestnumber='261030658836',
	updatedby = 'CJAMS-68416',
	updatedon = now()
where routingid in ('8d2def7e-29d5-42ce-b897-5f524b70a40f') and activeflag = 1;



update routing 
set 
	servicerequestnumber='241030274438',
	updatedby = 'CJAMS-68416',
	updatedon = now()
where routingid in ('bb1f3bee-0154-4847-be6f-b4bde8bb7699') and activeflag = 1;



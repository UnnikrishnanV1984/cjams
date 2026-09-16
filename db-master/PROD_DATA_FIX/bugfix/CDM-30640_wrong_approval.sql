/*
   Issue Description: CDM-30640
   Category/ Module  : routing
   Root cause: Case # 3240813 is assigned to Baltimore City but the Permanency Plan Review approval request come to Kathleen Chaney (Washington County) dashboard.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

--This was not executed in stage 3 and ticket reopened and asking to execute devops one more time 
--50714e61-37fc-4274-a3e4-88313c081498,    dd3ac302-59b9-4e32-ac55-94a0d551ee4f
update
	routing
set
	fromsecurityusersid = '53d4a7b0-6301-4f89-9c57-8d79946e5cc6' ,
	tosecurityusersid = '05819733-4b0a-443a-8636-5ef1212ec22f',
	updatedon = now(),
	updatedby = 'CDM-30640'
where
	routingid = '5f582579-cfe3-41f1-9c5d-c1b5c13145ce';
	
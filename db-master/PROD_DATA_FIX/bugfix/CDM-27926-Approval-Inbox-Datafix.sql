/*
   Issue Description: CDM-27926
   Category/ Module  : Approval Inbox
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
select 	activeflag, * 
from 	routing 
where 	tosecurityusersid = '10ed2d57-6e41-4a8e-93ac-63092fd2c62b' 
		and objectid in ('8d7770d2-f7d1-4c39-808b-afb0a17e12fd', 
		'0bd33769-801b-48a7-8517-a58326dd8bb4', 
		'68a59981-6d99-42a5-be4c-a8a4fb4e5fec') and activeflag = 1;

update 	routing
set 	activeflag = 0, updatedby = 'CDM-27926', updatedon = now()
where 	routingid in ('cc0fe2df-e868-4544-9d76-b9d30f661196',
		'aa47f670-6dfc-4d2a-99f9-07d5afeb77ba',
		'cc0c77b7-5422-42f4-948c-a39fc6ec359c') AND activeflag = 1;



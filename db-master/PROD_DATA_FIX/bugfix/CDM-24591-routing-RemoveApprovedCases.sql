-- CDM-24591 - Approved case still on my tree
/*
   File Name: CDM-24591-routing-RemoveApprovedCases
-- Issue Description: 
    For the case 3224595,3304559,3204331,3228617,3228617,3228617,3136017,3208796,3258392  - cases has been approved but is still visible in the bucket for the user.
    Customer Email ID:teresa.boston@maryland.gov
  
-- Resolution: Updated the Flag to zero in the routing table for the servicerequestnumbers ('221020246525')

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

update
	routing
set
	activeflag = 0,
	updatedby = 'CDM-24591',
	updatedon = now()
where
	routingid in ( '0b0ead3a-220c-43f3-95dd-9bc12849b4c2',
	'01f82c4b-b14e-415d-9165-7daece182ec7',
	'dccb76cc-0e02-4cd9-843a-89d040f29607',
	'5834ab5d-fc3b-4ba4-bf6c-8e943da81ee7',
	'e45579d5-2c2c-4044-a97c-0642cfc57d3d',
	'13b9a016-3f28-43a1-b55f-da55e6b6105c',
	'f6248f63-2b1a-4e95-9ec2-07475b99d693',
	'a176c128-8508-42b7-a191-e31776461cf1')
	and objectid in ('eed770dc-4f3b-424d-91e8-32bc5811dfb9',
	'8965126e-08ed-46cf-9bcd-a251738b838e',
	'969260d4-c9f2-49d1-a6a2-3d1a69a20a12',
	'b6d92928-5e87-4ada-b638-32992ce00c59',
	'b200ab1e-8657-4eac-b9d4-ee0d88ed2e8a',
	'b03a2502-639c-4702-bfcb-b49798603b20',
	'6340065e-c4d2-44f1-87fe-6894275163fd') and activeflag = 1;
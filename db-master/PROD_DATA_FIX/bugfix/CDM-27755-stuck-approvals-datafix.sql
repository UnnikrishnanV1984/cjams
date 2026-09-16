/*
   Issue Description: CDM-27755 - Stuck approvals
   Case # 3273706 & # The plan has been appproved yet remains in the approval box
   Category/ Module  : Approval Inbox
   Root cause: As per QA: Case # 3273706 & # The plan has been appproved yet remains in the approval box

   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do only data fix
*/

-- Case # 3273706
 
select	activeflag, routingid, routingstatustypeid, tosecurityusersid, * 
from 	routing 
where 	objectid in ('ed888e41-5083-48ed-ba8c-f78b84c69763'
		, 'f8da06f0-a404-4bb3-adcc-bac3aa1025b5'
		, '2e1d4d01-a9d4-40f7-898e-35ff1f793399'
		, '49e35567-f1ba-420a-9643-dd8e7a3034a6'
		, '0db27fc6-4e08-4591-8b9e-e4becc084a74'
		, '93250422-c05f-4fda-b3e3-f348c3cb51e5'
		, '64f65b6f-cb28-4f1b-b54c-784cfd72f59c'
		, '724d3214-55d3-459b-943e-866873421d2e'
		, '469e19ce-6712-43e8-9f69-be24e2aaa440'
		)
		and tosecurityusersid = '4d1dfcc6-5bbb-44c7-898a-a399f1229278' and activeflag = 1;

update 	routing
set 	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-27755'
where 	routingid in ('1bad1249-532f-4c2a-811b-e608b196a444'
						, '05eacfeb-9337-4037-bc32-8529cc9cd913'
						, '2bec2e24-05cd-45b4-9514-4acea7cf14cf'
						, '28c821cb-e1f4-4cc5-a9ef-a4cddb5ada00'
						, 'cd3e1b30-d0ec-4bc0-9210-63630fa6d159'
						, '9bc37857-4786-4ffb-8c12-f8c5ff4248e0'
						, 'f35e841f-7901-451b-8f25-06c9c35ca1f6'
						, '065c2d87-6300-4a49-a9a5-d30a47d065e1'
						, '60585258-4d55-41d2-9dc7-d626f374d2f4'
		)
		and activeflag = 1;



/*
   Issue Description: CDM-25882
   Category/ Module  : Approval Inbox
   
   Root cause: User requested to remove the pending approval inbox from user dashboard because user has approved it and Its still populated in user dashboard.
*/

select * from routing where routingid in  
	( '2a002bb9-24d2-4c29-bae7-42bc0ecb067e', --CPS Response Timer Skip Request to Supervisor
	'e4ebd949-686f-4cff-a4ee-f47b22250e2c'); --CPS Response Timer Save Approved

select * from routing where routingid in  
( '728703da-d812-4955-b7d6-38dfd8f34be8', --CPS Response Timer Skip Request to Supervisor
'7335ec1f-627e-4220-a3a0-e34ce8d14cb5'); --CPS Response Timer Save Approved

--CPS Response Timer Save Approved is already approved -- RoutingId 'e4ebd949-686f-4cff-a4ee-f47b22250e2c' -- servicerequestnumber 221020260336
--CPS Response Timer Skip Request to Supervisor - Pending - RoutingId - '2a002bb9-24d2-4c29-bae7-42bc0ecb067e' - Tobe deleted
--CPS Response Timer Save Approved is already approved -- RoutingId '7335ec1f-627e-4220-a3a0-e34ce8d14cb5' -- servicerequestnumber 221020256285
--CPS Response Timer Skip Request to Supervisor - Pending - RoutingId - '728703da-d812-4955-b7d6-38dfd8f34be8' - Tobe deleted

update 	routing
set 	activeflag = 0,
		updatedby = 'CDM-25882',
		updatedon = now()
where 	routingid in ('2a002bb9-24d2-4c29-bae7-42bc0ecb067e', '728703da-d812-4955-b7d6-38dfd8f34be8');



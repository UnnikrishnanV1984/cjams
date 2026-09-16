--Issue CDM-36359-Unable to Screen out case
/*
-- Issue Description: 
	Unable to screen out I231011673955 case where Approve button is enabled but user is not able to click on it.
-- Category/ Module: Decision
-- Root cause: Updated the routing table to properly screenout the case I231011673955
*/

update routing 
set routingstatustypeid='8',
    activeflag='0',
    updatedon = now()
where routingid='dc53c177-0d8f-471b-9d7a-d52993a9ad1b';
	
update routing 
set routingstatustypeid='1',
    activeflag='0',
    updatedon = now()
where routingid='5fa4d8be-68ef-4950-afcc-15c5c74a4add';
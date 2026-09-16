-- CDM-36150 - Payment
/*
-- Issue Description: 
   Dashboard:2844618 for Eric Lane was approved by me and it is not showing that it was approved Screen
   
-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: Data migration issue
-- Fix Provided: Datafix has been promoted to fix the routing data.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


select activeflag, routingstatustypeid, remarks,  * from routing 
where objectid = '2844618' and routingid='b514ead4-acf8-4e9f-8323-271c6db428e4';

update routing
set activeflag = 1,
	updatedby = 'CDM-36150',
	updatedon = now()
where routingid = 'b514ead4-acf8-4e9f-8323-271c6db428e4' and objectid='2844618';
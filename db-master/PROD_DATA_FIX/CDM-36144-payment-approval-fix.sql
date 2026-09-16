-- CDM-36144 - Missing Payment Information
/*
-- Issue Description: 
   This provider cannot be closed until all outstanding purchase authorizations (3278102)
   
-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: Data migration issue
-- Fix Provided: Datafix has been promoted to fix the routing data.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


select activeflag, routingstatustypeid, remarks,  * from routing 
where objectid = '2874889' and routingid='b3354c82-4635-4578-918f-a0ec61ecf13d';

update routing
set activeflag = 1,
	updatedby = 'CDM-36144',
	updatedon = now()
where routingid = 'b3354c82-4635-4578-918f-a0ec61ecf13d' and objectid='2874889';
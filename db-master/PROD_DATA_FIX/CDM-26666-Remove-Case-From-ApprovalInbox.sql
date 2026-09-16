
/*
-- CDM-26666 - 

-- Issue Description: 
 CDM-26666 - 221020253703:This case is stuck in my case pending approval inbox an a case connect and needs to be remove.
-- Customer Email ID:

-- Root cause: Data fix updated the activeflag to 0
-- Pull request# 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update routing set activeflag =0, updatedby = 'CDM-26666',
 updatedon = now() where routingid='02dd32f0-ac1d-4aed-bd83-51cc1c0c6d89' and activeflag =1;


 --delete service case 221030022294
 update servicecase set activeflag = 0, updatedby = 'CDM-26666', updatedon = now()
where servicecaseid = '889fcf2a-f14d-4156-93ce-8e9059df6f68';

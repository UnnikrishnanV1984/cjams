/*
-- Issue Description: 
-- CDM-19893: Approval Inbox
-- Category/ Module: Approval inbox 
-- Root cause: case approval for an YTP is still in approval box though it is approved
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

select 	activeflag, *
from 	routing 
where 	routingid = 'e1068724-2306-4a94-846f-6f5e43e420f3';

update 	routing 
set 	activeflag = 0,
		updatedby = 'CDM-19893',
		updatedon = now()
where 	routingid = 'e1068724-2306-4a94-846f-6f5e43e420f3' AND objectid = 'a0f455df-2aed-4589-82d4-b5020f1f7eef' and tosecurityusersid = '1af80afb-f9c9-479f-aae7-c8de29164925';
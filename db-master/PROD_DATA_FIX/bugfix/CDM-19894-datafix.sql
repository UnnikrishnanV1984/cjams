/*
-- Issue Description: 
-- CDM-19894: Approval Inbox
-- Category/ Module: Approval inbox 
-- Root cause: case approval for an YTP is still in approval box though it is approved
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

select 	activeflag, *
from 	routing 
where 	objectid = 'f785446d-cf0a-49a9-b6a5-7e1606a845a8' and routingid = 'aa6e6d23-b047-43f4-bb32-33b544e41142';

update 	routing 
set 	activeflag = 0,
		updatedby = 'CDM-19894',
		updatedon = now()
where 	routingid = 'aa6e6d23-b047-43f4-bb32-33b544e41142' AND objectid = 'f785446d-cf0a-49a9-b6a5-7e1606a845a8' and tosecurityusersid = '1af80afb-f9c9-479f-aae7-c8de29164925';
/*
   Issue Description: CDM-36580
   Category/ Module  : Approval Inbox 
   Root cause: Duplicate approval request.
   Fix: Data fix to delete the routing record as requested by user
   Pull request# for code fix: 
   Reason why no related code fix: 
*/



select * from routing 
	where objectid = '2955063' 
		and eventcode = 'PCAUTH' 
		and tosecurityusersid = '3e07111f-f5f9-4e72-92a7-9cd2d0c1791f'  -- Tanya Keene
		and activeflag = 1;
		
UPDATE routing
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36580'
	where routingid = 'e716830d-1a32-4fee-af96-ed481a521be6'
		and activeflag = 1;
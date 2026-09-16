-- CDM-36767 - Approval Inbox
/* Issue Description: Remove service plan approval request from dashboard

-- case number: 3169121 

-- Category/ Module: Aproval Inbox

-- Root cause: User request to remove service plan approval records from pending approval dashboard
-- Fix Provided: Datafix has been provided to soft delete routing records
-- Pull request# N/A

*/
select * from routing where objectid = '407fd34e-b96f-4a61-a5f8-888bfb2ec6bf' and eventcode = 'SPLAN' and activeflag = 1;

update routing
	set activeflag = 0,
		updatedby = 'CDM-36767',
		updatedon = now()
	where routingid in ('fae7a510-ca7a-465e-987c-88dc9746e28b','2bcf0862-ff94-48cb-b237-54c28bfd2e47')
		and activeflag = 1;
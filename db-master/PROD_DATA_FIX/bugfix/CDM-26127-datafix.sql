-- CDM-26127 - Approval Inbox
/*
-- Issue Description: 
	221020246528:Approval stuck in Approval Box
	
-- Category/ Module:  Approval Inbox
-- Root cause: Case Approval stuck in Inbox 

-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select 	activeflag, * from routing
where 	tosecurityusersid = 'b567fa07-daef-4762-b877-079ccd874a11'
		and objectid = '8e058cf5-62c4-4616-bbca-40d0cd6f4ad7';

update 	routing
set 	activeflag = 0,
		updatedby = 'CDM-26127',
		updatedon = now()
where 	routingid = 'f39dd617-34ae-4a5e-b10f-7b42c6e2db01' and activeflag = 1;
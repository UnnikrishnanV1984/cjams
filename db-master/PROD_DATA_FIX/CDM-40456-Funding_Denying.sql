/*
-- Issue Description: CDM-40456
-- Category/ Module: Funding Approval
-- Root cause: On funding denying user name is not showing in list and print voucher as well
-- Fix Provided: Datafix has been promoted to update service logs.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update routing 
    set tosecurityusersid  = 'f40ce63c-7b37-4a30-895a-683c5584cbb1',
        updatedby = 'CDM-40456',
        updatedon = NOW()
where objectid in ('3316632','3316700')
    and eventcode  in ( 'PCAUTHR', 'PCAUTH' )
    and routingstatustypeid  = 62;
	
	
	
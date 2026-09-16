-- CDM-16432 - Pending Service Log
/*
-- Issue Description: 
   Purchase Authorization with duplicate Pending routing record 

-- Authorization ID: 1786527 
-- Case ID: 3232587
-- Client ID: 200664407	(Isabella Rose Pace) - ab97133e-f00d-4568-9ce8-46886eb52f68
-- Srevice Log ID: 2006818 - Birth Certificate (Paid)
   
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete 
-- 1	40	Forwarded to Funding Approval	c717e5f5-4f96-4d01-a10f-3c8294aaca8b

select activeflag, routingstatustypeid, remarks,  *
	from routing 
where routingid = 'c717e5f5-4f96-4d01-a10f-3c8294aaca8b'	
	and objectid = '1786527'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
delete from routing   
where routingid = 'c717e5f5-4f96-4d01-a10f-3c8294aaca8b'	
	and objectid = '1786527'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;


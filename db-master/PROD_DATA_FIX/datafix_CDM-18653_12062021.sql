-- CDM-18653 - Supervisor signature in CJAMS
/*
-- Issue Description: 
   Authorization Approval Issue - Routing data issue 
   
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Was error in prior User story code 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: 
						This is resolved and the code fix is moved to PROD
*/

-- Mass Datafix to update tosecurityusersid (supervisors) for Forwarded to Case Supervisor
-- Which are manually approved via going to the Service Cases
select ro.objectid, ro.activeflag, ro.routingstatustypeid, ro.remarks, 
	ro.tosecurityusersid, ro.updatedby, ro.updatedon, 
	( select ro1.fromsecurityusersid
		from routing ro1
	  where ro1.objectid = ro.objectid
		and eventcode  in ( 'PCAUTHR', 'PCAUTH' )
		and ro1.routingstatustypeid <> 39
   	  order by ro1.insertedon  
      limit 1 
     ) as supervisor
    from routing ro
where routingstatustypeid = 39
	and ro.eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and ro.tosecurityusersid  is null
	and ro.activeflag = 0 ;

update routing ro
set tosecurityusersid 
		= ( select ro1.fromsecurityusersid
				from routing ro1
			  where ro1.objectid = ro.objectid
				and eventcode in ( 'PCAUTHR', 'PCAUTH' )
				and ro1.routingstatustypeid <> 39
			  order by ro1.insertedon  
			  limit 1 
		   ),
	updatedon = now(), 
	updatedby = 'CDM-18653'
where routingstatustypeid = 39
	and ro.eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and ro.tosecurityusersid  is null
	and ro.activeflag = 0 ;

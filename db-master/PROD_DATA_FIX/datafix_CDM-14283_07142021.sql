-- CDM-14283 - Funding Approved Transaction did not drop from the Screen
/*
-- Issue Description: 
   Approved Purchase Authorization with Pending routing records 

-- Authorization ID: 1781811 
-- Case ID: 3229728 & Client ID: 3581071
-- 40	Forwarded to Funding Approval	a55dfabb-9d01-4636-b0a6-4535bc81cf9f
-- 43	Approved						d9b27496-bda5-45b3-9dcd-921dbfd12f60
-- 43	Approved						c7f9b201-1877-47a5-8d6c-fba113bf01df

   
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 40	Forwarded to Funding Approval (1)
-- 43	Approved (2)
select eventcode, objectid, routingstatustypeid, remarks, activeflag, updatedby, updatedon 
	from routing 
where routingid in (	'a55dfabb-9d01-4636-b0a6-4535bc81cf9f', 
						'd9b27496-bda5-45b3-9dcd-921dbfd12f60',
						'c7f9b201-1877-47a5-8d6c-fba113bf01df'
					)	
	and objectid = '1781811'
	and activeflag = 1 ;

delete from routing   
where routingid in (	'a55dfabb-9d01-4636-b0a6-4535bc81cf9f', 
						'd9b27496-bda5-45b3-9dcd-921dbfd12f60',
						'c7f9b201-1877-47a5-8d6c-fba113bf01df'
					)	
	and objectid = '1781811'
	and activeflag = 1 ;


/*
 * CDM-37087 - Service Log Viewable to Fiscal Staff
 * Customer Email ID:evelyn.allende@maryland.gov
 * Description - Dashboard:Case ID# 221030016039; Service Request ID# 2919786; Auth# 2865451; Vendor is Fenwick Behavior Services (5089493). 
 * This request does not appear on any of our Fiscal Staff to approve- but needs to be approved and paid. It is stuck in the system without ablity to be approved.
 * On the Purchase Auth # 2865451, approval history showed the status as Approved but there's no Finance Name displayed.
 * Client ID: 3541942 (KEIRA JIANNINEY)
 * Provider ID# : 5089493 (Fenwick Behavioral Services)
 * 
 */

--  select routingid, tosecurityusersid, objectid, activeflag, routingstatustypeid, remarks, updatedby, updatedon
-- 	from routing 
-- where objectid = '2865451'
-- 	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;

UPDATE cjams.routing
SET activeflag=1, updatedby='CDM-37087', updatedon=now()  
WHERE routingid='34328631-baa7-4f0d-93f5-b7c7f2539166'::uuid;

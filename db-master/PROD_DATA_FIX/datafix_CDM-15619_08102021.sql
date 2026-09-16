-- CDM-15619 - Service log
/*
-- Issue Description: 
   User request to forward pending Purchase Authorizations to the new Program Manager
   
-- Case ID: 3126312
-- Client ID: 3616829 (JOSHUA SUTTON) - 31993c3b-e6de-4750-9b73-74bf29c007ac
-- Service Log ID: 1963581 (Service: One-on-One (Paid) - # 11338)
-- Provider ID: 5033282	(TIME Organization)
-- Auth IDs: 1758168, 1758169, 1758170, 1758171, 1758172, 
			  1758295, 1759660, 1763746, 1763748, 1765243, 
			  1765245, 1765246, 1767563, 1767583, 1767584, 
			  1769903, 1769904, 1775721, 1775722, 1775740, 
			  1775741, 1786674, 1786675, 1786802, 1786803, 
			  1786804, 1786805  
    
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
-- No Fix is required, Forwarded to Funding Approval as Role
-- So, CJAMS will allow any Baltimore City Fiscal Supervisor to approve these:
   Auth IDs: 1767563, 1767583, 1767584, 1769903, 1769904,
			  1786674, 1786675, 1786802, 1786803, 1786804,
			  1786805, 1775721, 1775722, 1775740, 1775741
*/

-- Fix
-- Currently forwared to Baltimore City user Christina Law - 422c4d43-cfa3-42da-b4f2-aad4ac9988fa
-- Forward to Baltimore City user Willette Parrish - c2e3548f-6209-4698-8cad-0c9ea12658b9

select objectid, tosecurityusersid, routingstatustypeid, remarks, updatedon, updatedby 
	from routing 
where objectid 	in ( 	1758168, 1763746, 1758169, 1763748, 1758170, 
						1765243, 1765245 ,1758171, 1765246, 1759660,
						1758172, 1758295 
					)
	and activeflag  = 1
	and tosecurityusersid = '422c4d43-cfa3-42da-b4f2-aad4ac9988fa' ;


update cjams.routing 
set tosecurityusersid = 'c2e3548f-6209-4698-8cad-0c9ea12658b9', 
	updatedon = now(), 
	updatedby = 'CDM-15619'
where objectid 	in ( 	1758168, 1763746, 1758169, 1763748, 1758170, 
						1765243, 1765245 ,1758171, 1765246, 1759660,
						1758172, 1758295 
					)
	and activeflag  = 1
	and tosecurityusersid = '422c4d43-cfa3-42da-b4f2-aad4ac9988fa' ;
	
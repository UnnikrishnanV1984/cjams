-- CDM-16940 - Pending flex funds
/*
-- Issue Description: 
   User request to forward the below pending Purchase Authorizations to Program Manager Role
   
-- Case ID: 3247266
-- Client ID: 3731865 (DAVAR TYRESE	WILLIAMS) - 31bbe14c-0807-4e9c-9721-43d195f5584a
-- Currently Forwared To (Christina Law) - 422c4d43-cfa3-42da-b4f2-aad4ac9988fa
-- Want to Approve (Willette Parrish) - c2e3548f-6209-4698-8cad-0c9ea12658b9

-- Auth IDs:	1767869, 1767867, 1767866, 1767105, 1767104, 
				1767103, 1767102, 1767101 ,1767100, 1767099 
    
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Fix
-- Currently forwared to Baltimore City user Christina Law - 422c4d43-cfa3-42da-b4f2-aad4ac9988fa
-- Forward to Baltimore City Program Manager Role

select objectid, eventcode, tosecurityusersid, routingstatustypeid, remarks, updatedon, updatedby 
	from routing 
where activeflag  = 1
	and routingstatustypeid = '42'
	and routingid 
		in ( 
			'7cfd5459-363f-42a9-b83c-9e3b136407d4', 'db89a1a5-c3cb-488a-a152-bf160a5126fd',
			'698aaf6c-dc52-41be-b50f-4fa98382df48', '481f7fd0-acfe-468d-8603-9e0446e02a49', 
			'845c1675-5382-4565-9733-73b312f804f9', '20154ecc-b713-4e77-a830-32e5c204820a', 
			'fa9e96e1-52ee-46fe-a895-52b9aac7b736', '682cbf00-0a54-42ba-88dc-8cbab987196d', 
			'273c743b-9667-426b-9b83-c6a6b74011e5', 'b04e0a43-8fca-4a16-bc07-61cfca5ebccd'
			) 
	and objectid in ( 	1767869, 1767867, 1767866, 1767105, 1767104, 
						1767103, 1767102, 1767101 ,1767100, 1767099 
					)
	and tosecurityusersid is not null;				
			
update cjams.routing 
set eventcode = 'PCAUTHR',
	tosecurityusersid = NULL, 
	updatedon = now(), 
	updatedby = 'CDM-16940'
where activeflag  = 1
	and routingstatustypeid = '42'
	and routingid 
		in ( 
			'7cfd5459-363f-42a9-b83c-9e3b136407d4', 'db89a1a5-c3cb-488a-a152-bf160a5126fd',
			'698aaf6c-dc52-41be-b50f-4fa98382df48', '481f7fd0-acfe-468d-8603-9e0446e02a49', 
			'845c1675-5382-4565-9733-73b312f804f9', '20154ecc-b713-4e77-a830-32e5c204820a', 
			'fa9e96e1-52ee-46fe-a895-52b9aac7b736', '682cbf00-0a54-42ba-88dc-8cbab987196d', 
			'273c743b-9667-426b-9b83-c6a6b74011e5', 'b04e0a43-8fca-4a16-bc07-61cfca5ebccd'
			) 
	and objectid in ( 	1767869, 1767867, 1767866, 1767105, 1767104, 
						1767103, 1767102, 1767101 ,1767100, 1767099 
					)
	and tosecurityusersid is not null;
	
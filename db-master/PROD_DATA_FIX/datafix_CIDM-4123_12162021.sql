-- CIDM-4123 - User permission - SSA placement manager
/*
-- Issue Description: 
   To nullify the tosecurityusersid in the routing tabel for Fiscal Category Code 7108 (Hospital/Psych Overstay)
   This is a generic workaround script we can use until the code fix (next prod build).
  
-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: TDB (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- nullify the tosecurityusersid in the routing tabel for Fiscal Category Code 7108 (Hospital/Psych Overstay)
select objectid, routingid, eventcode, remarks, tosecurityusersid, activeflag, updatedby, updatedon 
	from routing 
where eventcode = 'PCAUTHR'
	and activeflag = 1 
	and tosecurityusersid is not null
	and objectid 
		in ( select authorization_id 
				from tb_service_purchase_authorization 
			 where btrim(fiscal_category_cd)  = '7108'
				and delete_sw = 'N'
				and sprvsr_approval_status_cd is null
				and ads_approval_status_cd is null
				and funding_approval_status_cd is null
				and payment_approval_status_cd is null 
			) ;
			
update routing
set tosecurityusersid = NULL,
	updatedby = 'CIDM-4123',
	updatedon = now()	
where eventcode = 'PCAUTHR'
	and activeflag = 1 
	and tosecurityusersid is not null
	and objectid 
		in ( select authorization_id 
				from tb_service_purchase_authorization 
			 where btrim(fiscal_category_cd)  = '7108'
				and delete_sw = 'N'
				and sprvsr_approval_status_cd is null
				and ads_approval_status_cd is null
				and funding_approval_status_cd is null
				and payment_approval_status_cd is null 
			) ;
	
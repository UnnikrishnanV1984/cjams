
/*
-- Issue Description: There are ten duplicate purchase authorizations created for the same service date period which was created on 02/06/2026.
	Client ID: 200901285 (Hendrix Strobel)
	Provider ID: 5028858 (Worcester County Department of Social Services)
	Service: Health maintenance (Paid)

-- Category/ Module: Service Log (Case Management) 
-- Root cause: User error.  
-- Fix Provided: Datafix has been promoted to remove the  duplicate records.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--select *, authorization_id from tb_service_purchase_authorization tspa where authorization_id = 4237170;

UPDATE tb_service_purchase_authorization
SET delete_sw = 'Y', update_ts= now(), update_user_id = 'CJAMS-65681' 
WHERE authorization_id  in('4237170','4237168','4237166','4237165','4237163','4237162','4237160','4237159','4237158') 
    and delete_sw = 'N'
    and sprvsr_approval_status_cd is null
    and ads_approval_status_cd is null
    and funding_approval_status_cd is null
    and payment_approval_status_cd is null ;
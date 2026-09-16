/*
-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: Requested to Remove the highlighted purchase authorization (Auth ID# 4237311 & 4237337) it might have caused due to causing by the CJAMS slowness issue.
-- Fix Provided: Datafix has been promoted to delete the requested un-apporved Authorization 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/





UPDATE tb_service_purchase_authorization SET delete_sw = 'Y', update_ts= now()::character varying, 
update_user_id = 'CJAMS-65246' WHERE authorization_id in (4237337 , 4237311) 
    AND delete_sw = 'N'
    AND sprvsr_approval_status_cd IS NULL
    AND ads_approval_status_cd IS NULL
    AND funding_approval_status_cd IS NULL
    AND payment_approval_status_cd IS NULL;
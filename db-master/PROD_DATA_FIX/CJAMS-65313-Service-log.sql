/*
 Issue Description: CIDM-65313 Delete purchase authorization
 Category/ Module  : Purchase Authorization

 Root cause: User wants to remove the purchase authorization. Please delete Purchase Authorization. 
 fix: Datafix has been added to delete the record.
 Pull request# for code fix: 
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date:
 */


 UPDATE tb_service_purchase_authorization
SET delete_sw = 'Y', update_ts= now(), update_user_id = 'CJAMS-65313'
WHERE authorization_id  in ('4237161', '4237171', '4237172')
    and delete_sw = 'N'
    and sprvsr_approval_status_cd is null
    and ads_approval_status_cd is null
    and funding_approval_status_cd is null
    and payment_approval_status_cd is null ;
	



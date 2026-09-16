/*
   Issue Description: CDM-25723
   Category/ Module  :Rotuing 
   Pull request# for code fix:  
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update cjams.routing  set activeflag =0, updatedby='CDM-25723', updatedon = now()

where routingid ='0662c456-4912-4afa-843a-c5c54d0b8269';


update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CDM-25723'
where authorization_id = 1843552
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

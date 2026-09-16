/*
   Issue Description: CDM-31141
   Category/ Module  : Servicelog
   Root cause: User request 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/


update tb_service_purchase_authorization set delete_sw ='Y' , update_ts=now(), update_user_id ='CDM-31141' where service_log_id = '1959625' and authorization_id ='1736183';

update routing set activeflag=0, updatedby='CDM-31141', updatedon = now() where routingid='36e9997e-774c-494d-b845-fa5e185b88c4';


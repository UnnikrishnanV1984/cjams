/*
   Issue Description: CDM-43094 - Purchase Authorization
   Category/ Module  :  Purchase Authorization
   Root cause: User asked to delete it.
   Pull request# for code fix: NA
   Reason why no related code fix: NA 
*/

update tb_service_purchase_authorization 
set delete_sw='Y', update_ts=now(),update_user_id='CDM-43094' 
where authorization_id  in ('3235746' , '3226819' , '3226784' , '3226751' , '3013992' , '2707127' , '2707093');

update routing 
set activeflag=0, updatedon=now(), updatedby='CDM-43094'
where objectid in ('3235746' , '3226819' , '3226784' , '3226751' , '3013992' , '2707127' , '2707093');
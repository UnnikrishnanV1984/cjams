/*
   Issue Description: CDM-7917 - Purchase Authorization
   Category/ Module  :  Purchase Authorization
   Root cause: User asked to delete it.
   Pull request# for code fix: NA
   Reason why no related code fix: NA 
   Status of the code fix if already submitted and expected prod fix date:  NA
*/
update tb_service_purchase_authorization set delete_sw='Y', update_ts=now(),update_user_id='CDM-7917' where authorization_id=1750340;
update routing set activeflag=0, updatedon=now(), updatedby='CDM-7917' where objectid=1750340;
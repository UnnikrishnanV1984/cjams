/*
   Issue Description: CDM-31150
   Category/ Module  :Approval inbox
   Root cause: user want to remove case from the user pending approval dashboard.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 
update routing set activeflag=0 ,updatedby = 'CDM-31150', 
updatedon = now() where activeflag=1 and  routingid ='47d3fe70-1c64-491b-ac52-ee7de5fa7f61';


update tb_service_purchase_authorization set delete_sw='Y',update_ts=NOW(),update_user_id='CDM-31150' where delete_sw='N' and authorization_id=2131648;

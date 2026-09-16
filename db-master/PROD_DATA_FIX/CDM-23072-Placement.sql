/*
   Issue Description: CDM-23072
   Category/ Module  : Placement
   Root cause: user wants to change the address of living arrangement and end data change 
   Pull request# for code fix: 5705
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/


update placement set enddatetime = '2021-05-21 00:00:00', updatedby = 'CDM-23072', updatedon = now() where placementid = 'dd8c6770-fd27-4c5d-b513-b63a3250e627';
update livingarrangement set livingenddate = '2021-05-21 00:00:00' , updatedby = 'CDM-23072', updatedon = now() where placementid = 'dd8c6770-fd27-4c5d-b513-b63a3250e627';

update tb_provider_addresses set adr_default_sw = 'Y', update_ts = now(), update_user_id = 'CDM-23072'  where address_id = 109469;



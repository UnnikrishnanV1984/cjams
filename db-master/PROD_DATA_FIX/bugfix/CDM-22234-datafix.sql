/*
   Issue Description: CDM-22234
   Category/ Module  : Purchase Authorization
   Root cause: Purchase Authorization Print Error. Funding approval was approved by another supervisor instead of the assigned supervisor
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select  tosecurityusersid, objectid 
from     routing 
where   objectid in ('1829104', '1829102', '1829087') 
and routingstatustypeid=39;

update  routing 
set     tosecurityusersid='0726c881-b01a-47bd-8af2-587781346e7c' 
where   objectid in ('1829104', '1829102', '1829087') 
and routingstatustypeid=39;


select  supervisor_name, supervisor_staff_id 
from    tb_slpa_snapshot  
where   authorization_id in ('1829104', '1829102', '1829087');

update  tb_slpa_snapshot 
set     supervisor_name='Charles Wood', supervisor_staff_id = '200008643'  
where   authorization_id in ('1829104', '1829102', '1829087');
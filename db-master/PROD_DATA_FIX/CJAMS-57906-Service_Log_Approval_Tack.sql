/*
  Issue Description:  CJAMS-57906
   Category/ Module  :  Purchase authorization Funding approval
   Root cause: User requested to update the pending approval to other person
   Pull request# for code fix: 
   Reason why no related code fix: User Error
*/

update routing set toroleid = 'FNSFW', updatedon = now(), updatedby='CJAMS-57906' 
where objectid = '3715829' and routingid = 'b361f536-b65e-4530-8746-c0c838422896' and activeflag ='1';

update routing set toroleid = 'FNSFW', updatedon = now(), updatedby='CJAMS-57906' 
where objectid = '3715845' and routingid = '5951556e-7ac3-46bf-a5cf-45041839123b' and activeflag ='1';
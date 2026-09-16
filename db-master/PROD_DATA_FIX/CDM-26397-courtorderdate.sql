/*
   Issue Description: CDM-26397
   Category/ Module  : Court
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservreqcourtorder set courtorderdate  = '2019-11-12 00:00:00', updatedby = 'CDM-26397', updatedon = now()
where intakeservreqcourtorderid = '7938b8c5-6397-4cf6-9787-b5c6ae451638';

update intakeservreqchildremoval set exitdate =null, updatedby ='CDM-26397', updatedon = now()  where intakeservreqchildremovalid ='1741af0f-8f71-4350-b171-1af23954d42e' and activeflag =1;


update personprogramarea set enddate =null, updatedby ='CDM-26397', updatedon = now()  where personprogramid ='1e6d06b5-0406-4071-b128-8ebee5df0388' and activeflag =1;

update tb_client_eligibility set delete_sw = 'Y' ,
update_user_id = 'CDM-26397', update_ts = now()
where removal_id ='188779';
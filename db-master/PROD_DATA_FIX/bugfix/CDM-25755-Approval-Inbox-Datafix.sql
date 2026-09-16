/*
   Issue Description: CDM-25755
   Category/ Module  : Approval Inbox
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
select 	activeflag, * 
from 	routing
where 	routingid in ('8fae0e7a-bb71-4da8-bb37-422816c6474a') AND activeflag = 1;

update 	routing
set 	activeflag = 0, updatedby = 'CDM-25755', updatedon = now()
where 	routingid in ('8fae0e7a-bb71-4da8-bb37-422816c6474a') AND activeflag = 1;

/*
   Issue Description: CDM-25880
   Category/ Module  : Approval Inbox
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
select 	activeflag, * 
from 	routing
where 	routingid in ('baa23957-9dc9-4182-a0f4-6b52fb5a36d2','520e12b6-88ba-4122-a899-67cb56561e41') AND activeflag = 1;

update 	routing
set 	activeflag = 0, updatedby = 'CDM-25880', updatedon = now()
where 	routingid in ('baa23957-9dc9-4182-a0f4-6b52fb5a36d2','520e12b6-88ba-4122-a899-67cb56561e41') AND activeflag = 1;

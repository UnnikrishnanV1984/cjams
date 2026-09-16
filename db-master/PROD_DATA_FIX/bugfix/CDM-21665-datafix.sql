/*
   Issue Description: CDM-21665
   Category/ Module  : Approval Inbox
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
select 	activeflag, * 
from 	routing
where 	routingid in ('54e09a68-61cf-4d11-adeb-d9a84095c0f8','381fb62a-ec07-4587-8c5e-89da447485e5') AND activeflag = 1;

update 	routing
set 	activeflag = 0, updatedby = 'CDM-21665', updatedon = now()
where 	routingid in ('54e09a68-61cf-4d11-adeb-d9a84095c0f8','381fb62a-ec07-4587-8c5e-89da447485e5') AND activeflag = 1;
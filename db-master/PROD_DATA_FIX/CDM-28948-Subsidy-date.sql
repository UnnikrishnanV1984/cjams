/*
   Issue Description: CDM-28948
   Category/ Module  :permanency-plan
   Pull request# for code fix: Change date
   Reason why no related code fix: 8107
   Status of the code fix if already submitted and expected prod fix date: 
*/


select 	gapagreementrateid, gapagreementid, startdate, enddate, paymentamout,  *
from 	gapagreementrate 
where 	gapagreementrateid = '54b34261-9f0e-457f-8436-0ec1c9d41720' and gapagreementid = '04288562-fe7d-41e8-993f-e99ab11ac29c';  

update 	gapagreementrate 
set 	startdate = '2023-03-09 00:00:00', enddate = '2024-03-08 00:00:00', updatedby='CDM-28948', updatedon=now() 
where 	gapagreementrateid = '54b34261-9f0e-457f-8436-0ec1c9d41720' and gapagreementid = '04288562-fe7d-41e8-993f-e99ab11ac29c'; 

select 	ratestartdate, * 	from gapratesrevision 
where 	gaprateid in ('54b34261-9f0e-457f-8436-0ec1c9d41720');

update 	gapratesrevision 
set 	ratestartdate = '2023-03-09 00:00:00', rateenddate = '2024-03-08 00:00:00', updatedby='CDM-28948', approvaldate = now(),  updatedon=now() 
where 	gaprateid in ('54b34261-9f0e-457f-8436-0ec1c9d41720');


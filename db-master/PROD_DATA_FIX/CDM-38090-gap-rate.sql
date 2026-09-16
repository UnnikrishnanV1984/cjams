/*
 Issue Description:
 	CDM-38090: Corrected rate period
 	1. 3210431:Please do a data fix to change the current subsidy rate slab start date from 10/01/2023 to 06/01/2023.
 Category/ Module: GAP
 Root cause: We need the subsidy rate to begin on 06/01/2023.User Request
 Fix Provided: Data Fix has been promoted toNeed Datafix to change the current subsidy rate slab start date from 10/01/2023 to 06/01/2023.
               Case number: 3210431,  
 Pull request# 	N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/

--update enddate for the record : gapagreementrateid = '19e3b138-f1f0-4f03-b8ab-530653bdafdf'
select 	gapagreementrateid, gapagreementid, startdate, enddate, paymentamout,  *
from 	gapagreementrate 
where 	gapagreementrateid = '19e3b138-f1f0-4f03-b8ab-530653bdafdf' and gapagreementid = '717609f2-837b-4253-9d5f-5e2054c947de';  

update 	gapagreementrate 
set 	startdate='2023-06-01 00:00:00', updatedby='CDM-38090', updatedon=now() 
where 	gapagreementrateid = '19e3b138-f1f0-4f03-b8ab-530653bdafdf' and gapagreementid = '717609f2-837b-4253-9d5f-5e2054c947de';

select 	ratestartdate, * 	from gapratesrevision 
where 	gaprateid in ('19e3b138-f1f0-4f03-b8ab-530653bdafdf');

update 	gapratesrevision 
set 	ratestartdate='2023-06-01 00:00:00', updatedby='CDM-38090', approvaldate = now(),  updatedon=now() 
where 	gaprateid in ('19e3b138-f1f0-4f03-b8ab-530653bdafdf');


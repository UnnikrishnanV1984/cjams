/*
 Issue Description:
 	CDM-37834: 10 Days missing payments
 	1. 2020035004820:This worker is requesting for the service date to be changed to 11/24/2023 and the provider is missing 10 days payments of subsidy benefits.
 Category/ Module: GAP
 Root cause: 	We need the subsidy rate to begin on 11/14/23 not 11/24/23. Finance is requiring this to be fixed inside the system. They will address the overlap in payment dates but the subsidy rate has to begin on 11/14/23 as that's when the child left care.
 Fix Provided: Data Fix has been promoted toNeed Datafix to change the Subsidy rate begin date as 11/14/23 for
               Case number: 2020035004820,  
 Pull request# 	N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/

--update enddate for the record : gapagreementrateid = '650fdf7e-e796-49a3-8385-d09cfbf6d3c0'
select 	gapagreementrateid, gapagreementid, startdate, enddate, paymentamout,  *
from 	gapagreementrate 
where 	gapagreementrateid = '650fdf7e-e796-49a3-8385-d09cfbf6d3c0' and gapagreementid = 'd1994cdb-0720-4c6c-bd4d-8f5460fb2a0c';  

update 	gapagreementrate 
set 	startdate='2023-11-14 00:00:00', updatedby='CDM-37834', updatedon=now() 
where 	gapagreementrateid = '650fdf7e-e796-49a3-8385-d09cfbf6d3c0' and gapagreementid = 'd1994cdb-0720-4c6c-bd4d-8f5460fb2a0c';

select 	ratestartdate, * 	from gapratesrevision 
where 	gaprateid in ('650fdf7e-e796-49a3-8385-d09cfbf6d3c0');

update 	gapratesrevision 
set 	ratestartdate='2023-11-14 00:00:00', updatedby='CDM-37834', approvaldate = now(),  updatedon=now() 
where 	gaprateid in ('650fdf7e-e796-49a3-8385-d09cfbf6d3c0');

select 	*
from 	gapratesrevision
where 	activeflag = 1
		and approvaldate is not null
		and gaprateid in ( select gapagreementrateid
		from gapagreementrate
		where gapagreementid  = 'd1994cdb-0720-4c6c-bd4d-8f5460fb2a0c'
		)
		and gaprateid not in ('650fdf7e-e796-49a3-8385-d09cfbf6d3c0');

update 	gapratesrevision
set 	approvaldate = now(),  
		updatedon = now(),
		updatedby = 'CDM-37834'
where 	activeflag = 1
		and approvaldate is not null
		and gaprateid in ( select gapagreementrateid
		from gapagreementrate
		  where gapagreementid  = 'd1994cdb-0720-4c6c-bd4d-8f5460fb2a0c'
		 )
		and gaprateid not in ('650fdf7e-e796-49a3-8385-d09cfbf6d3c0');

select 	gapagreementrateid, gapagreementid, startdate, enddate, paymentamout,  *
from 	gapagreementrate
where 	gapagreementid = 'd1994cdb-0720-4c6c-bd4d-8f5460fb2a0c'
		and gapagreementrateid <> '650fdf7e-e796-49a3-8385-d09cfbf6d3c0';

update 	gapagreementrate
set 	updatedby='CDM-37834', updatedon=now()
where 	gapagreementid = 'd1994cdb-0720-4c6c-bd4d-8f5460fb2a0c'
		and gapagreementrateid <> '650fdf7e-e796-49a3-8385-d09cfbf6d3c0';


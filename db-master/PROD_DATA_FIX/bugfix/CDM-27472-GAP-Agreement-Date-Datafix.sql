/*
 Issue Description:
 	CDM-27472: Remove end date
 	1. the subsidy rate begin date is listed as 12/18/2018 meanwhile the agreement start date is entered as 12/19/2018. 
 		Need data fix to change the subsidy rate begin date to 12/19/2018
 Category/ Module: GAP
 Root cause: 	The subsidy rate begin date is listed as 12/18/2018 meanwhile the agreement start date is entered as 12/19/2018. 
 				Need data fix to change the subsidy rate begin date to 12/19/2018
 Pull request# 	N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/

--update enddate for the record : gapagreementrateid = '4baae581-45d8-49fc-94ab-60c00cb669d6'
select 	gapagreementrateid, gapagreementid, startdate, enddate, paymentamout,  *
from 	gapagreementrate 
where 	gapagreementrateid = '4baae581-45d8-49fc-94ab-60c00cb669d6' and gapagreementid = '49efe3e8-e9bf-419e-b67b-e9df8674f56a';  

update 	gapagreementrate 
set 	startdate='2018-12-19 00:00:00', updatedby='CDM-27472', updatedon=now() 
where 	gapagreementrateid = '4baae581-45d8-49fc-94ab-60c00cb669d6' and gapagreementid = '49efe3e8-e9bf-419e-b67b-e9df8674f56a';

select 	ratestartdate, * 	from gapratesrevision 
where 	gaprateid in ('4baae581-45d8-49fc-94ab-60c00cb669d6');

update 	gapratesrevision 
set 	ratestartdate='2018-12-19 00:00:00', updatedby='CDM-27472', approvaldate = now(),  updatedon=now() 
where 	gaprateid in ('4baae581-45d8-49fc-94ab-60c00cb669d6');

select 	*
from 	gapratesrevision
where 	activeflag = 1
		and approvaldate is not null
		and gaprateid in ( select gapagreementrateid
		from gapagreementrate
		where gapagreementid  = '49efe3e8-e9bf-419e-b67b-e9df8674f56a'
		)
		and gaprateid not in ('4baae581-45d8-49fc-94ab-60c00cb669d6');

update 	gapratesrevision
set 	approvaldate = now(),  
		updatedon = now(),
		updatedby = 'CDM-27472'
where 	activeflag = 1
		and approvaldate is not null
		and gaprateid in ( select gapagreementrateid
		from gapagreementrate
		  where gapagreementid  = '49efe3e8-e9bf-419e-b67b-e9df8674f56a'
		 )
		and gaprateid not in ('4baae581-45d8-49fc-94ab-60c00cb669d6');

select 	gapagreementrateid, gapagreementid, startdate, enddate, paymentamout,  *
from 	gapagreementrate
where 	gapagreementid = '49efe3e8-e9bf-419e-b67b-e9df8674f56a'
		and gapagreementrateid <> '4baae581-45d8-49fc-94ab-60c00cb669d6';

update 	gapagreementrate
set 	updatedby='CDM-27472', updatedon=now()
where 	gapagreementid = '49efe3e8-e9bf-419e-b67b-e9df8674f56a'
		and gapagreementrateid <> '4baae581-45d8-49fc-94ab-60c00cb669d6';


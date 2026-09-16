/*
 Issue Description:
 	CDM-27385: GAP
 	1. User requested to update the Gap Agreement Rate details
 Category/ Module: Referral
 Root cause: 	User requested to update the Gap Agreement Rate details For Client SHYNIA CHRISTIAN
 					enddate 12/31/22 to be  changed to 11/30/2022  for amount 273 and 
 					start date has to be 12/01/2022 -  end date has to be 11/30/2023 for the amount of $166
 Pull request# 	N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/

--update enddate for the record which has amount 273 : gapagreementrateid = '4cea84af-2717-4c53-b83b-060a97057355'
select 	gapagreementrateid, gapagreementid, startdate, enddate, paymentamout,  *
from 	gapagreementrate 
where 	gapagreementrateid = '4cea84af-2717-4c53-b83b-060a97057355' and gapagreementid = 'd25d1f01-c45e-4c14-a285-a918fb1289fa'; --273 

update 	gapagreementrate 
set 	enddate='2022-11-30', updatedby='CDM-27385', updatedon=now() 
where 	gapagreementrateid = '4cea84af-2717-4c53-b83b-060a97057355' and gapagreementid = 'd25d1f01-c45e-4c14-a285-a918fb1289fa'; ;

update 	gapratesrevision 
set 	rateenddate='2022-11-30', approvaldate = now(), updatedby='CDM-27385', updatedon=now() 
where 	gaprateid in ('4cea84af-2717-4c53-b83b-060a97057355');

--update start and enddate with new values for the record which has amount 166 : gapagreementrateid =  '5a1b27ee-c938-4aa0-9931-6979151f0c94'
select 	gapagreementrateid, gapagreementid, startdate, enddate, paymentamout,  *
from 	gapagreementrate 
where 	gapagreementrateid =  '5a1b27ee-c938-4aa0-9931-6979151f0c94' and gapagreementid = 'd25d1f01-c45e-4c14-a285-a918fb1289fa'; --166 

update 	gapagreementrate 
set 	startdate = '2022-12-01', enddate='2023-11-30', updatedby='CDM-27385', updatedon=now() 
where 	gapagreementrateid =  '5a1b27ee-c938-4aa0-9931-6979151f0c94' and gapagreementid = 'd25d1f01-c45e-4c14-a285-a918fb1289fa';

update 	gapratesrevision 
set 	ratestartdate = '2022-12-01', rateenddate='2023-11-30', approvaldate = now(), updatedby='CDM-27385', updatedon=now() 
where 	gaprateid in ('5a1b27ee-c938-4aa0-9931-6979151f0c94');

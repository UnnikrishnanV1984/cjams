/*
   Issue Description: CDM-28920
   Category/ Module  :Wrong subsidy start dat
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


select gapagreementid, startdate, enddate, paymentamout, updatedby, updatedon, activeflag 
	from gapagreementrate 
where gapagreementrateid = '5a163e1b-464c-49be-844f-5e8bfd57d9f6'
	and activeflag = 1 ;

update gapagreementrate 
set startdate = '2022-12-07 00:00:00',
    enddate = '2023-12-06 00:00:00',
    updatedon=now(), updatedby='CDM-28920'
where gapagreementrateid = '5a163e1b-464c-49be-844f-5e8bfd57d9f6'
and activeflag = 1 ;


select approvalstatustypekey, approvaldate, ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon 
from gapratesrevision 
where gaprateid = '5a163e1b-464c-49be-844f-5e8bfd57d9f6' and activeflag = 1 ;


update gapratesrevision 
set ratestartdate = '2022-12-07 00:00:00',
rateenddate = '2023-12-06 00:00:00',
approvaldate = now(),
updatedon=now(), updatedby='CDM-28920'	
where gaprateid = '5a163e1b-464c-49be-844f-5e8bfd57d9f6' and activeflag = 1 ;



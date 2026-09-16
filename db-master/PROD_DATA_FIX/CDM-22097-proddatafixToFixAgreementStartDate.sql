
/*
   Issue Description: CDM-22097
   Category/ Module  : Prod data fix To update agreement end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update gapagreement 
set startdate = '2022-01-22 05:00:00',
	updatedby = 'CDM-22097',
	updatedon = now()
where gapagreementid = 'e3e966f1-baed-4fa8-ab57-2d0471cf83b7'
	and activeflag = 1 ;

update gapagreementrevision
set startdate = '2022-01-22 05:00:00',
	approvaldate = now(),
	updatedby = 'CDM-22097',
	updatedon = now()
where gapagreementid = 'e3e966f1-baed-4fa8-ab57-2d0471cf83b7' ;

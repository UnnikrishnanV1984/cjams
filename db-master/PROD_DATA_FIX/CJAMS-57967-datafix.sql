/*
   Issue Description: CJAMS-57967
   Category/ Module  : subsidy rate 
   Root cause: User requested to update the subsidy rate to $902
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update gapagreementrate 
set paymentamout=902,
	updatedby = 'CJAMS-57967',
	updatedon = now()
where gapagreementrateid = '80249c64-878c-4422-8c76-a11c2ca45204'
	and activeflag = 1 ;
	
update gapratesrevision 
set paymentamt =902, approvaldate =now(), updatedon =now(), updatedby ='CJAMS-57967'
where gaprateid ='80249c64-878c-4422-8c76-a11c2ca45204';

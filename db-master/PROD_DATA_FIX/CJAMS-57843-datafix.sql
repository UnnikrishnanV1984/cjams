/*
   Issue Description: CJAMS-57843
   Category/ Module  : Data fix to  update gap amount
   Root cause: User requested to update the gap amount
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update gapagreementrate 
set paymentamout=835,
	updatedby = 'CJAMS-57843',
	updatedon = now()
where gapagreementrateid = 'b2b16609-18ed-4419-aa88-6248ada2face'
	and activeflag = 1 ;
	

update gapratesrevision 
set paymentamt =835, approvaldate =now(), updatedon =now(), updatedby ='CJAMS-57843'
where gaprateid ='b2b16609-18ed-4419-aa88-6248ada2face';
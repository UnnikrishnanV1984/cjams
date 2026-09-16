/*
   Issue Description: CDM-22926
   Category/ Module  : Prod data fix to update gap amount
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- 902
update gapagreementrate 
set paymentamout = 887.00,
	updatedby = 'CDM-22926',
	updatedon = now()
where gapagreementrateid = 'fba5e7e1-e9e9-45f9-9778-f08c66016a69'
	and activeflag = 1 ;

-- Datafix to trigger Under/Over 902
update gapratesrevision 
set paymentamt = 887.00,
	approvaldate = now(),
	updatedby = 'CDM-22926',
	updatedon = now()
where gaprateid = 'fba5e7e1-e9e9-45f9-9778-f08c66016a69' ;


/*
   Issue Description: CDM-17915
   Category/ Module  : Reverting Intake case connect
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update routing
set routingstatustypeid  = 1,
activeflag = 1,
updatedon = now(),
updatedby = 'CDM-17915'
where objectid = 'I211010205529' and eventcode = 'INTR' and activeflag = 1;

update intakedastatus
set status = 1,
updatedon = now(),
updatedby = 'CDM-17915'
where intakenumber = 'I211010205529' and activeflag = 1;

update intakedastaging
set status = 'pending',
ispreintake = FALSE,
updatedon = now(),
updatedby = 'CDM-17915'
where intakenumber = 'I211010205529' and activeflag = 1;


update servicecase set activeflag = 0, updatedon =  now(), updatedby = 'CDM-17915' where servicecasenumber = '211030011858';

/*
   Issue Description: CDM-18019
   Category/ Module  : Reverting Intake decision
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update routing
set routingstatustypeid  = 1,
activeflag = 1,
updatedon = now(),
updatedby = 'CDM-18019'
where objectid = 'I211010186913' and eventcode = 'INTR' and activeflag = 1;

update intakedastatus
set status = 1,
updatedon = now(),
updatedby = 'CDM-18019'
where intakenumber = 'I211010186913' and activeflag = 1;

update intakedastaging
set status = 'pending',
ispreintake = FALSE,
updatedon = now(),
updatedby = 'CDM-18019'
where intakenumber = 'I211010186913' and activeflag = 1;


update servicecase set activeflag = 0, updatedon =  now(), updatedby = 'CDM-18019' where servicecasenumber = '211020136582';
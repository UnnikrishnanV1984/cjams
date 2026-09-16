/* Issue Description:CDM-13500 - Reverting back the supervisor decission
   Category/ Module  :  Decission tab
   Root cause: unable to reproduce this
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

*/



update intakedastaging 
set jsondata = replace (jsondata::text,  '"DAStatus": "Approved"', '"DAStatus": "Review"' )::jsonb,
    updatedby = 'CDM-14118', 
    updatedon = now()
where intakenumber = 'I211010163842' and activeflag = 1;


update servicecase set activeflag = 0, updatedby = 'CDM-14118', updatedon = now() where servicecaseid = 'c98b96c8-78f6-4476-a42a-5baa526cbd5f';

update routing
set routingstatustypeid  = 1,
eventcode = 'INTR',
updatedon = now(),
updatedby = 'CDM-14118'
where objectid = 'I211010163842';

update intakedastatus
set status = 1,
updatedon = now(),
updatedby = 'CDM-14118'
where intakenumber = 'I211010163842' and activeflag=1;

update intakedastaging
set status = 'pending',
ispreintake = FALSE,
updatedon = now(),
updatedby = 'CDM-14118'
where intakenumber = 'I211010163842' and activeflag = 1;


update intakesnapshot
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-14118'
where intakenumber ='I211010163842';
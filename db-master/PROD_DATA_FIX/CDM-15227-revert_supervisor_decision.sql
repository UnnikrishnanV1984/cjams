/* Issue Description:CDM-15227 - Reverting back the supervisor decission
   Category/ Module  :  Decission tab
   Root cause: unable to reproduce this
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

*/

update intakedastaging 
set jsondata = replace (jsondata::text,  '"DAStatus": "Approved"', '"DAStatus": "Review"' )::jsonb,
    updatedby = 'CDM-15227', 
    updatedon = now()
where intakenumber = 'I211010175127' and activeflag = 1;

update routing
set routingstatustypeid  = 1,
eventcode = 'INTR',
updatedon = now(),
updatedby = 'CDM-15227'
where objectid = 'I211010175127';

update intakedastatus
set status = 1,
updatedon = now(),
updatedby = 'CDM-15227'
where intakenumber = 'I211010175127' and activeflag=1;

update intakedastaging
set status = 'pending',
ispreintake = FALSE,
updatedon = now(),
updatedby = 'CDM-15227'
where intakenumber = 'I211010175127' and activeflag = 1;


update intakesnapshot
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-15227'
where intakenumber ='I211010175127';
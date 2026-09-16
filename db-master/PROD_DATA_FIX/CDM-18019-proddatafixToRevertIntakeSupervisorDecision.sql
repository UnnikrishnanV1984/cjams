
/*
   Issue Description: CDM-18019
   Category/ Module  : Reverting Supervisor Decision
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakedastaging 
set jsondata = replace (jsondata::text,  '"DAStatus": "Approved"', '"DAStatus": "Review"' )::jsonb,
    updatedby = 'CDM-18019', 
    updatedon = now()
where intakenumber = 'I211010186913' AND activeflag=1;
update intakedastaging 
set jsondata = replace (jsondata::text,  '"DAStatus": "Review"', '"DAStatus": "Accepted"' )::jsonb,
    updatedby = 'CDM-11557', 
    updatedon = now()
where intakenumber = 'I202100136920' and activeflag = 1;

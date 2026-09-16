/*
   Issue Description: CDM-13456
   Category/ Module  : Intake SDM 
   Root cause: user wants change the Fatality to NO
   Pull request# for code fix: 7389
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    This is an existing issue, Need to do data fix
*/
update intakedastaging 
set jsondata = replace(jsondata::text, '"childfatality": "no"', '"childfatality": "yes"')::json, updatedby = 'CDM-13456', updatedon = now()
 where intakenumber = 'I202100448216' and activeflag = 1;
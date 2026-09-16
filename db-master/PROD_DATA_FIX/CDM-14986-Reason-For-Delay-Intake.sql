/*
   Issue Description: CDM-14986
   Category/ Module  : Decision in Intake 
   Root cause: user wants to add reason for delay in intake decision
   Pull request# for code fix: 7464
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  Need to do data fix
*/
update intakedastaging 
set jsondata = replace(jsondata::text, '"reason": "",' , '"reason": "Referral is delayed in approval due to the worker being unable to confirm clarifying information/details timely from the reporter.",')::json, 
updatedon = now(),updatedby = 'CDM-14986' where intakenumber = 'I211010171913' and activeflag = 1;

update intakesnapshot 
set jsondata = replace(jsondata::text, '"reason": "",' , '"reason": "Referral is delayed in approval due to the worker being unable to confirm clarifying information/details timely from the reporter.",')::json, 
updatedon = now(),updatedby = 'CDM-14986' where intakenumber = 'I211010171913' and activeflag = 1;

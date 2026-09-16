/*
   Issue Description: CDM-18866
   Category/ Module  : Agrrement date change
   Root cause: user wants to start date removal and placement 
   Pull request# for code fix: 4599
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update serviceagreement set agreementdate = '2021-11-22 00:00:00', updatedon = now(),
updatedby = 'CDM-18866' where agreementid = '2579c6d1-9f3c-4f2b-aca7-33267373b602';

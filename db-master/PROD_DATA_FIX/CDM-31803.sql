/*
   Issue Description: CDM-31803
   Category/ Module  :  
   Root cause: user want to Remove intakes from pending review dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update routing set activeflag=0,updatedby='CDM-31803',updatedon=now() where routingid='b58f509b-4f1b-424f-bd0e-9eeb4641300f' ;
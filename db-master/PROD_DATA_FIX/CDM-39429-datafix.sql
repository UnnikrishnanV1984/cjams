/*
   Issue Description: CDM-39429
   Category/ Module  : Decision
   Root cause: Case is showing open but there is no intake showing a case was screened in. Case needs to be closed as it looks like there is a services case that has been open for a month to a family receiving no services.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update servicecase set activeflag =0, updatedby = 'CDM-39429', updatedon = now() 
where servicecaseid = 'e2ccdf34-2584-4d3a-ada9-0b9a384b85ce' and activeflag=1;

update servicecasedisposition set activeflag = 0, updatedby = 'CDM-39429', updatedon = now() 
where servicecaseid = 'e2ccdf34-2584-4d3a-ada9-0b9a384b85ce' and activeflag=1;

update servicecaserequest set activeflag = 0, updatedby = 'CDM-39429', updatedon = now() 
where servicecaseid = 'e2ccdf34-2584-4d3a-ada9-0b9a384b85ce' and activeflag=1;

update routing set activeflag=0 where objectid='e2ccdf34-2584-4d3a-ada9-0b9a384b85ce'
and eventcode='SRVC' and activeflag = 1;


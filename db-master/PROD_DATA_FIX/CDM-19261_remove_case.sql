/*
   Issue Description: CDM-19261
   Category/ Module  : Service case
   Root cause: user wants to remove person other
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select * from cjams.servicecase s where servicecasenumber = '211030011959';

update servicecase set activeflag = 0, updatedby='CDM-19261', updatedon=now() 
where servicecasenumber = '211030011959';

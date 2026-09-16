/*
   Issue Description: CDM-
   Category/ Module  : remove service case 
   Root cause: user wants to delete service case
   Pull request# for code fix: 5063
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update servicecase set activeflag =0, updatedby = 'CDM-21076', updatedon = now() 
where servicecaseid = '1aa55584-0d29-456f-99e2-4bd78c12ad9d';

update caseassignment set activeflag = 0, updatedby = 'CDM-21076', updatedon = now() 
where objectid = '1aa55584-0d29-456f-99e2-4bd78c12ad9d' and activeflag = 1 ;

update servicecasedisposition set activeflag = 0, updatedby = 'CDM-21076', updatedon = now() 
where servicecaseid = '1aa55584-0d29-456f-99e2-4bd78c12ad9d';

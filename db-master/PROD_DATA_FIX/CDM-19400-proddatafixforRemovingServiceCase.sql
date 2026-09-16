
/*
   Issue Description: CDM-19400
   Category/ Module  : Removing Service case
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update servicecase set activeflag = 0, updatedon = now(),updatedby = 'CDM-19400' where servicecasenumber in ('211030012769','211030010172');
update caseassignment set activeflag = 0, updatedon = now(),updatedby = 'CDM-19400' where objectid in ('6b9ece24-c65d-4974-9ee9-cb8ec94f07c9');
update routing set activeflag = 0, updatedon = now(),updatedby = 'CDM-19400' where servicerequestnumber in ('211030012769','211030010172');

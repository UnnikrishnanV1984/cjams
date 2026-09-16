/* 
   Issue Description: CDM-25665
   Category/ Module  : Duplicate Clients 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

update cjams.actor 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-22963'
where personid in ('0293638b-e2d6-4f3c-a740-3edfc39b22c8', '2888a8c7-d32a-40d7-b842-0330062359dc');

update cjams.intakeservicerequestactor
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-22963'
where personid in ('0293638b-e2d6-4f3c-a740-3edfc39b22c8', '2888a8c7-d32a-40d7-b842-0330062359dc');

update cjams.personrole 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-22963'
where personid in ('0293638b-e2d6-4f3c-a740-3edfc39b22c8', '2888a8c7-d32a-40d7-b842-0330062359dc');

update cjams.actorrelationship 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-22963'
where intakeservicerequestactorid in (select  intakeservicerequestactorid from intakeservicerequestactor where personid in ('0293638b-e2d6-4f3c-a740-3edfc39b22c8', '2888a8c7-d32a-40d7-b842-0330062359dc'));
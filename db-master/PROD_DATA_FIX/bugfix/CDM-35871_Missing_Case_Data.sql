/*
 Issue Description: CDM-35871
 Category/ Module : Persons:Household
 Root cause: Servicecase is created but the intake data is missing.
 Fix: Deleting the service case record from servicecase, servicecase disposition and routing tables
 Pull request# for code fix: 
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
 */
update
    servicecase
set
    activeflag = 0,
    updatedby = 'CDM-35871',
    updatedon = now()
where
    servicecaseid in ('1c8f7391-cdc9-4a9c-a3eb-39b7772d7ab5');

update
    servicecasedisposition
set
    activeflag = 0,
    updatedby = 'CDM-35871',
    updatedon = now()
where
    servicecaseid = '1c8f7391-cdc9-4a9c-a3eb-39b7772d7ab5';

-- Get routingid
select
    *
from
    routing
where
    objectid = '1c8f7391-cdc9-4a9c-a3eb-39b7772d7ab5'
    and tosecurityusersid = '494f88e1-526f-4158-a40c-a2f2aaca985a';

-- Assigned to first name Qadry
update
    routing
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-35871'
where
    routingid = 'c967f846-e8cc-470c-bf39-c3d6b06bab5c';

---- Deleting case assignment table as well
update
    caseassignment
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-35871'
where
    objectid = '1c8f7391-cdc9-4a9c-a3eb-39b7772d7ab5';

-- Deleting routing record also as there is no intake to connect to
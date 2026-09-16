/*
   Issue Description: CDM-27011
   Category/ Module  :  Delete Skip Request
   Root cause: delete the overdue save request from approval inbox as the case#221020256680 is already in completed status.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update
    routing
set
    activeflag = 0,
    updatedby = 'CDM-27011',
    updatedon = now()
where
    routingid = 'f2550886-fdf5-4897-b6d1-24acf7def1fd' AND servicerequestnumber = '221020256680';
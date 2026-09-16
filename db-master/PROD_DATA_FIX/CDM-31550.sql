/*
   Issue Description: CDM-31550
   Category/ Module  : 
   Root cause: User want to change caseworker and Supervisor name
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/
update routing set fromsecurityusersid='ee86845e-ead2-420b-898f-66b4dd207f4e' ,tosecurityusersid='47194b3d-bf52-416c-a53b-82888c49d6a2',updatedby='CDM-31550',updatedon=now()
where objectid='8aa08c63-3314-4f05-b6fb-6fdc475d6b84';
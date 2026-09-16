
/*
   Issue Description: CDM-31700
   Category/ Module  :Permanency plan
   Root cause: wrong established date 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update permanencyplan set establisheddate='2017-09-08 00:00:00',updatedby='CDM-31700',updatedon=now()
where permanencyplanid='3baf41d5-d734-4215-9330-ba1b8e36e6ed';
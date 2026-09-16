/*
   Issue Description: CDM-25862
   Category/ Module  : Service paln
   Root cause: user requested  to add supervisor approval date
   Pull request# for data fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update serviceplan set enddate = '2021-04-27 04:00:00',
updatedby ='CDM-25862',
updatedon = now() 
where serviceplanid ='9e822933-714e-4ef9-bc75-b94bfb837ec8';
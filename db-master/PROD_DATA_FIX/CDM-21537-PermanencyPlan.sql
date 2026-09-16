/*
   Issue Description: CDM-21537
   Category/ Module  : Permanency plan
   Root cause: user wants to add end date and reason 
   Pull request# for code fix: 5188
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update permanencyplan set reason ='Created in Error', enddate = '2018-03-13', updatedby ='CDM-21537', 
updatedon =now() where permanencyplanid ='a46cb89a-f906-4588-afb3-f1577c315d2e';

update permanencyplan set reason ='Created in Error', enddate = '2018-03-13', updatedby ='CDM-21537', 
updatedon =now() where permanencyplanid ='8b606531-9880-44b4-9d6a-345431e21ef4';

update permanencyplan set reason ='Created in Error', enddate = '2018-03-13', updatedby ='CDM-21537', 
updatedon =now() where permanencyplanid ='4aa3ae1a-0b71-4865-a372-088976466eb6';


update permanencyplan set reason ='Created in Error', enddate = '2018-06-22', updatedby ='CDM-21537', 
updatedon =now() where permanencyplanid ='48aa6449-eaa5-47ed-a2f7-368f2304dc67';

update permanencyplan set reason ='Created in Error', enddate = '2018-06-22', updatedby ='CDM-21537', 
updatedon =now() where permanencyplanid ='9bb56a4f-4f24-4fc9-a48f-cb3c9f3094e5';
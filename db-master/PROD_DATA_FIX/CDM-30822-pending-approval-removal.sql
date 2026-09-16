/*
   Issue Description: CDM-30822
   Category/ Module  :  Remove Pending Approval
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update 
   routing 
set 
   activeflag = 0, 
   updatedby ='CDM-30822' ,
   updatedon = now() 
where 
   routingid ='9224367b-c8d6-4e3c-909a-bf5659ae8fee';
/*
   Issue Description: CDM-30828
   Category/ Module  :  Remove Pending Approval
   Pull request# for code fix: 8837
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update 
   routing 
set 
   activeflag = 0, 
   updatedby ='CDM-30828' ,
   updatedon = now() 
where 
   routingid ='62617546-71f3-434c-889c-be0f2d11f8e6';
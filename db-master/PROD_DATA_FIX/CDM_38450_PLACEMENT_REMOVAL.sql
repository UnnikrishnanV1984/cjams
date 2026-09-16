/*
   Issue Description: CDM-38450
   Category/ Module  :placement removal
   Root cause: user wants to change
   Pull request# for code fix: 
   Reason why no related code fix: 
   user is asked to remove the placement which is not required and there is another fix where user cannot able to edit the placement whcih 
   was already addressed as a part of another ticket
*/

update placement 
set activeflag = 0, updatedby = 'CDM-38450', updatedon = now()
where placementid = 'd0434d39-a138-437b-bdba-572a84e9f5c0'  and activeflag = 1;

update placementrevision 
set activeflag = 0, updatedby = 'CDM-38450', updatedon = now()  
where placementid = 'd0434d39-a138-437b-bdba-572a84e9f5c0'
 and activeflag = 1;

update routing 
set activeflag = 0, updatedby = 'CDM-38450', updatedon = now()
where routingid = '74531a95-cad2-4d0a-aa50-c02a88c9dc00' and activeflag = 1;
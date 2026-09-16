/*
   Issue Description: CDM-40437 Issue with adding person to Household
   Category/ Module  :Persons
   Root cause: Unable to move the child from others to household members in the person profile and role is not getting populated.
               This is happening due to the latest changes made in the actor id and will be fixed as the part of CDM-40443
   Fix provided : Data fix has been promoted to deactivate the duplicate actor id that was created with the service case 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/


update actor
set activeflag = 1,
    updatedby='CDM-40437',
    updatedon = now()
where actorid = '0b5be3e3-4385-4ed8-a7bd-050e8f3fd7ed'
and activeflag = 0;    
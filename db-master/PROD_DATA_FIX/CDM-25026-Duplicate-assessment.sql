/* Issue Description:CDM-25026 - Dashboard:I have approved these two assessments 
several times from August 30, 2022 but the same assessments continue to appear.
   Category/ Module  :  Contacts Information
   Root cause: unable to reproduce this
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

*/



update caseassignment set activeflag=0, updatedby = 'CDM-25026',
 updatedon = now() where caseassignmentid = '21af480b-0b5d-452c-a540-a186992e7c04' and activeflag = 1;

update caseassignment set activeflag=0, updatedby = 'CDM-25026', 
updatedon = now() where caseassignmentid = '051ce6da-5f87-43ef-9e82-a36c7c1e77e0' and activeflag = 1;

update routing set activeflag  =0, updatedby  = 'CDM-25026', updatedon  =now() 
where  objectid ='956c94a1-0cda-4062-a222-580d1e6c35b7' and activeflag = 1; 

update routing set activeflag  =0, updatedby  = 'CDM-25026', updatedon  =now() 
where  objectid ='56ea52cf-f373-443a-8788-9b17a4975802' and activeflag = 1;

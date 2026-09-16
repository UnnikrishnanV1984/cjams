/*
   Issue Description: CDM-22428
   Category/ Module  : Prod data fix To remove voided placements
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update placement set activeflag = 0, updatedby = 'CDM-22428', updatedon = now() where placementid in ('3bf9e257-618f-4a47-8f37-39c19331d669','9aba1f21-9395-440d-b8f9-556dabb0af10') and activeflag = 1;
update placementrevision set activeflag = 0, updatedby = 'CDM-22428', updatedon = now() where placementid in ('3bf9e257-618f-4a47-8f37-39c19331d669','9aba1f21-9395-440d-b8f9-556dabb0af10') and activeflag = 1;

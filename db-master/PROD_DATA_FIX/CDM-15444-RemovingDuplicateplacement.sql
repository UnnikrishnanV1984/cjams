
/*
   Issue Description: CDM-15444
   Category/ Module  :  Removing Duplicate placement
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update placement set activeflag = 0, updatedby = 'CDM-15444', updatedon = now() where placementid = 'c803e422-e3ed-4911-9954-50e1079d3584';

update  placementrevision set activeflag = 0, updatedby = 'CDM-15444', updatedon = now() where placementrevisionid = '7f2aa485-2f8d-470d-992b-28d5ae53db62';

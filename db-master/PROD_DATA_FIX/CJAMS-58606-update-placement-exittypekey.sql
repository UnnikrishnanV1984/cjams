/*
   Issue Description: CJAMS-58606
   Category/ Module  : Placeemnt
   Root cause: Unable to approve placement
   Pull request# for code fix: 
   Reason why no related code fix:
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/
update placementrevision 
set exittypekey ='CIPS' ,
 updatedby  ='CJAMS-58606',
 updatedon =now() 
 where placementrevisionid ='0d4c1271-adaf-423f-b77f-a7800347cb3e'
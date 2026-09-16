/*
   Issue Description: CDM-22365
   Category/ Module  : duplicate adoption planning records
   Root cause: user wants to remove the duplicate intake and delete service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/




update adoptionplanning set activeflag= 0, updatedby='CDM-22365', updatedon= now()
where adoptionplanningid in (
'85b14c92-a12f-4cf5-8c37-1f28d6877e3a',
'870afc20-62e6-40f3-b03d-2d91ce4ec172',
'4a3b03dd-2c4c-4e38-976d-f0aa03688a83',
'e4d435a4-30c2-411a-9c95-88776cd1d3f4',
'95d3afac-89a2-4a9f-bef5-bfaead822ab8',
'e29b58c6-5263-4b36-bce2-78578c095a38',
'd790e825-64c2-4244-b418-091e994de9a0',
'855424a8-e70a-453a-b2b2-d2688009fbe5',
'7c2ea4c7-e956-42ff-9305-b3967b9e99f3'
) and activeflag = 1;
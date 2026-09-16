/*
   Issue Description: CJAMS-58736 Unnamed Maltreator not anonymous
   Category/ Module  : Persons: Household
   Root cause: Incorrect Alleged maltreator removed in the case but it still shows in the global search of case.
               Maltreator has been removed from investigationallegation table as the part of  CDM-23395 but still exists in investigationfinding table
               Data fix should resolve it.
   Fix Provided: Data fix has been done to remove the incorrect maltreator from the investigation findings table.
   Data/Code fix ticket#: CJAMS-58736
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: Maltreator has been removed from investigationallegation table as the part of  CDM-23395 but still exists in investigationfinding
                                   Data fix should resolve it.
*/


update investigationfinding
set activeflag = 0,
    updatedby = 'CJAMS-58736',
    updatedon = now()
where investigationfindingid ='f0514e2f-667a-473b-b9d6-e964777c4d8e'
and activeflag = 1;    

/*
   Issue Description: CJAMS-68190 Unnamed Maltreator not anonymous
   Category/ Module  : Persons: Household
   Root cause: Please carry out data fix to remove marked records in the Investigation Findings against the alleged maltreator (Kaylen Ridley) with maltreatment type as Neglect.  
   Fix Provided: Data fix has been done to remove the incorrect maltreator from the investigation findings table.
   Data/Code fix ticket#: CJAMS-68190
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: Maltreator has been removed from investigationallegation table as the part of  CDM-23395 but still exists in investigationfinding
                                   Data fix should resolve it.
*/


update investigationallegation
set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-68190' 
where investigationallegationid in ('743397ef-8f79-4379-ba52-62253938f18e', '470d5356-8da0-4540-bb20-616656f3d0df') and activeflag = 1;


update investigationallegationmaltreators 
set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-68190' 
where investigationallegationid in ('743397ef-8f79-4379-ba52-62253938f18e', '470d5356-8da0-4540-bb20-616656f3d0df') and activeflag = 1;

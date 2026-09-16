/*
   Issue Description: CDM-30674
   Category/ Module  : Person Program Area
   Root cause: Wrongly CPS program has been given to the person
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

UPDATE cjams.personprogramarea
SET updatedon=now(), updatedby='CDM-30674', activeflag=0
WHERE personprogramid='bf4a67d0-f963-4e3e-bf7b-f14c3d1ddef1' and personid='7b86353a-a53a-4086-9445-86f890f944d6';

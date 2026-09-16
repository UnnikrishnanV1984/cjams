/*
-- Issue Description: CDM-35688 Delete duplicate investigation finding
-- Category/ Module: Inverstigation Finding  (Case Management) 
-- Root cause: User error
---Fix Provided: Datafix has been provided for deleting the duplicate investigation Findings
*/

select *from investigationallegation 
where investigationallegationid='c4c45ba4-6b25-4c52-919a-75c663412790'
and activeflag=1;

update
   investigationallegation
set
   activeflag = 0,
   updatedby = 'CDM-35688',
   updatedon = now()
where
   investigationallegationid = 'c4c45ba4-6b25-4c52-919a-75c663412790';
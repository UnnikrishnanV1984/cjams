/*
-- Issue Description: CDM-35706 Remove investigation finding
-- Category/ Module: Inverstigation Finding  (Case Management) 
-- Root cause:User would like to have Christopher Fuller be removed from the investigation finding
---Fix Provided: Datafix has been provided for deleting the investigation Findings
*/

select *from investigationallegation 
where investigationallegationid='6b122461-e0e7-4da6-aeb7-d0fab7949bdb'
and activeflag=1;

update
   investigationallegation
set
   activeflag = 0,
   updatedby = 'CDM-35706',
   updatedon = now()
where
   investigationallegationid = '6b122461-e0e7-4da6-aeb7-d0fab7949bdb';
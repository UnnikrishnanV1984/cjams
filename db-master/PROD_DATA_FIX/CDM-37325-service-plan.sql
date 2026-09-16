/*
   Issue Description: CDM-37325
   Category/ Module  : service plan 
   Root cause: Head of household is displayed wrogly in pdf file for in home 
   Fix: Fix has been provided to update Head of household name.
*/

-- Backup
select snapshotdata,updatedby,updatedon from snapshothist where objectid = '0a6b4bcd-d206-4c06-8870-e6350911154a';
--  and activeflag = 1;

-- Update
update snapshothist 
set snapshotdata = replace(snapshotdata::text, '"legalGuardian": "VICTORIA SMITH "', '"legalGuardian": "Kelsey Kraupa Marker"')::json, 
updatedby = 'CDM-37325', updatedon = now()
where objectid = '0a6b4bcd-d206-4c06-8870-e6350911154a';
--  and activeflag = 1;
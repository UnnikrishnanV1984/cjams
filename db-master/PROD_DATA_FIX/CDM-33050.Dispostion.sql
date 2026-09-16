/*
   Issue Description: CDM-33050
   Category/ Module  : Servicecase
   Root cause: User requested to remove case reopen records 
  Fix Provided: Did data fix to remove reopen records  
*/
--Removing one more extra record as per qa suggestion 

update cjams.servicecasedisposition set activeflag =0, updatedby ='CDM-33050', updatedon = now()
where servicecasedispositionid in ('6a9589ae-eaf8-4a1b-aa26-44f7e23e54f8','ebb1d5ed-3655-46e3-b164-e01eb6d6dd07','e80dba06-1f6d-47ba-adbf-edbe1e07ae19');

update servicecase
set statustypekey = 'Closed',
dispositioncode = 'Closed',
enddate = '2018-08-08 12:00:00',
updatedby = 'CDM-33050', 
updatedon = now()
where servicecasenumber = '3232848'
and activeflag = 1 ;

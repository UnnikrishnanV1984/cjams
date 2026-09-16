/*
   Issue Description: CDM-37740
   Category/ Module  : Document    
   Root cause: ecmsdocumetid is missing so user not able download that file
   Fix Provided: Did data fix to add ecmsdocumetid
*/


update cjams.documentproperties set ecmsdocumentid  ='65f0b872e499a96a84328ddc', updatedby ='CDM-37740', updatedon = now()
where documentpropertiesid  ='192f3f6d-2f05-49e6-a5df-1809e2d3cbe7';
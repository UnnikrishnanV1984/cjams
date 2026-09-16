/*
   Issue Description: CDM-33328
   Category/ Module  : contact note
   Root cause: user request 
   Fix Provided: Did data fix  to change worker visit to monthly visit
*/

update cjams.progressnote set progressnotereasontypekey ='MV', updatedby ='CDM-33328', updatedon = now()
where progressnoteid ='8ad342ce-8da6-4705-a64f-b8520fba7b39';

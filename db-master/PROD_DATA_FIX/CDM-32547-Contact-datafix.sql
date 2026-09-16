/*
   Issue Description: CDM-32547
   Category/ Module  : Contact notes
   Root cause: user wants to change contact date 
   Fix Provided: Did data fix to changed the contact date 
*/

update cjams.progressnote set contactdate ='2023-06-15 00:00:00', updatedby ='CDM-32547'
where progressnoteid ='2738fc8a-5ea0-4a3f-9505-0444b871b429';
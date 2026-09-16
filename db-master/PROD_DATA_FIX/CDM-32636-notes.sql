/*
   Issue Description: CDM-32636
   Category/ Module  : Contact notes
   Root cause: user wants to change contact entry date 
   Fix Provided: Did data fix to changed the contact date 
*/

-- for this case there is no responce timer 

update cjams.progressnote set contactdate ='2023-06-20 00:00:00', starttime ='2023-06-20 13:00:00', endtime ='2023-06-20 13:10:00', updatedon ='2023-06-20 09:40:46', updatedby ='CDM-32636'
where progressnoteid ='9945636a-5289-417c-acea-cdd9233dbd0a';
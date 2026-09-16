/*
  Issue Description:  CDM-39736
   Category/ Module  :  Contacts
   Root cause: user requested to update the contact note date to 06/11/2024 from 06/10/2024
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update progressnote
set contactdate='2024-06-11 00:00:00.000',
updatedby='CDM-39739',
updatedon=now()
where progressnoteid ='1beec653-f411-416c-8a1a-87ec34a07de7' and activeflag =1;
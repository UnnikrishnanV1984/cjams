/*
  Issue Description:  CJAMS-67078
   Category/ Module  :  Contacts
   Root cause: user requested to update the contact note date from 03/26/2026 to 04/02/2024
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update progressnote
set contactdate='2026-04-02 00:00:00',
updatedby='CJAMS-67078',
updatedon=now()
where progressnoteid ='f1e3805e-a4de-4489-b523-d4bcf57cdaaa' and activeflag =1;
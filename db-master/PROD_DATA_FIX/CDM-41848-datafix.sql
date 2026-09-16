/*
  Issue Description:  CDM-41848
   Category/ Module  : Contacts: Notes
   Root cause: User request to remove the duplicate contact notes
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update progressnote set activeflag = 0, updatedon = now(), updatedby = 'CDM-41848' 
where progressnoteid = 'db7b6c16-07a4-428a-8f3d-63514d3bd980';

update progressnotedetail set activeflag  = 0, updatedon = now(), updatedby = 'CDM-41848'
where progressnoteid = 'db7b6c16-07a4-428a-8f3d-63514d3bd980' and activeflag  = 1;
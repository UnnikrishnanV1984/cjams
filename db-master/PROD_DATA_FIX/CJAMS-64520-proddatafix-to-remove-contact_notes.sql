/*
  Issue Description:  CJAMS-64520
   Category/ Module  : Contacts: Notes
   Root cause: User request to remove the duplicate contact notes
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update progressnote set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-64520' 
where progressnoteid = 'd92f7125-76b6-406c-9534-dcd1a2c44385' and activeflag  = 1;

update progressnotedetail set activeflag  = 0, updatedon = now(), updatedby = 'CJAMS-64520'
where progressnoteid = 'd92f7125-76b6-406c-9534-dcd1a2c44385' and activeflag  = 1;
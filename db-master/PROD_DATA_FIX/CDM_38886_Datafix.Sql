/*
  Issue Description:  CDM-38886
   Category/ Module  : Documents
   Root cause: User request to remove the Document
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update documentproperties set activeflag = 0, updatedon = now(),
updatedby = 'CDM-38886'
where ecmsdocumentid ='663b87a0237c201c6c2169b6' and activeflag = 1;

update documentattachment set activeflag = 0, updatedon = now(),
updatedby = 'CDM-38886' 
where documentattachmentid ='a2db26d2-73ba-4496-8e85-63fa41eecef6' and activeflag = 1;

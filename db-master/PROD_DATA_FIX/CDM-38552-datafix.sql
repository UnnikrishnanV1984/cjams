/* 
    Issue Description: CDM-38552
  Category/ Module  : Documents
  Root cause: removed the respective document from the list under the Documents tab 
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/


update documentproperties set activeflag = 0, updatedon = now(),
updatedby = 'CDM-38552'
where ecmsdocumentid ='635aa0f77b7864363b617375' and activeflag = 1;

update documentattachment set activeflag = 0, updatedon = now(),
updatedby = 'CDM-38552' 
where documentattachmentid in  ('573c09e9-2343-4344-a3e1-b115ac0e6fb4','73a602a1-6f51-4b03-b286-e0054068df93') and activeflag = 1;

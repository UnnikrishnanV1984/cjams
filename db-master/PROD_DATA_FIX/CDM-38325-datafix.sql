/* 
    Issue Description: CDM-38325
  Category/ Module  : 
  Root cause: User request to delete document from Documents tab 
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/


update documentproperties set activeflag = 0, updatedon = now(),
updatedby = 'CDM-38325'
where ecmsdocumentid ='6221055106d7130924438b12' and activeflag = 1;

update documentattachment set activeflag = 0, updatedon = now(),
updatedby = 'CDM-38325' 
where documentattachmentid in  ('7e067676-2299-4165-a4f2-efa71818f916','6490deec-321d-480f-8aa6-40972a76560d') and activeflag = 1;

/*
   Issue Description: CDM-14224
   Category/ Module  : notes deletion 
   Root cause: User requested to delete the duplicate notes
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update
    progressnotedetail
set
    activeflag = '0',
    updatedby = 'CDM-14224',
    updatedon = now()
where
    progressnoteid = '448a1899-44c3-4b56-b36b-327554080bdc'
    and progressnotedetailid = '798f1197-ed1c-42cf-9898-eaa098ae8131';
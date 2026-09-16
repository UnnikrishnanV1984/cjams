/*
   Issue Description: CDM-24033
   Category/ Module  : Prod data fix to assessment status type key
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update assessment set assessmentstatustypekey = 'InProcess', updatedby = 'CDM-24033' , updatedon = now()
where objectid = '7320b85a-cc37-41f4-8a5e-da384aae2ea9' and assessmentstatustypekey = '' and assessmenttemplateid = 'e88a1ea0-39d7-49a5-8560-612b38f6bef1';

/*
   Issue Description: CDM-32105
   Category/ Module  : Case Plan  
   Root cause: user unable to send caseplan for approval because of user role 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.teammember
SET roletypekey='CWCW', updatedby='CDM-32105', updatedon=now()
WHERE teammemberid='9203b8d3-bda9-4415-ac88-5de6b5084083';

UPDATE cjams.rolemapping
SET  roleid=71,  updatedby='CDM-32105', updatedon=now()
WHERE principalid ='19795' and activeflag =1;
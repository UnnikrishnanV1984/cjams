/*
   Issue Description: CJAMS-68982
   Category/ Module  : SDM 
   Root cause: safec checklist is not checked in ar summary
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update caseassignment
set  enddate= '2021-08-06 16:24:37',updatedby = 'CJAMS-68982',updatedon = now()
where caseassignmentid='54aba74a-7a2e-4c00-b470-afd05acbec2c' and activeflag  = 1;

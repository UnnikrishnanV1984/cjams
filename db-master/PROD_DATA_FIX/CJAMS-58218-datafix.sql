/*
   Issue Description: CJAMS-58218
   Category/ Module  : Persons: Others
   Root cause: Data fix done to update the Previous Adoption Date in Persons tab to be 11/07/2006
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update person set preadoptiondate = '2006-11-07 00:00:00.000',
updatedby = 'CJAMS-58218', updatedon = now()
where personid = 'f4bc7930-e687-4fe5-9a2c-e61403bd9854' and activeflag = 1;
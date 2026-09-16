/*
   Issue Description: CJAMS-58219
   Category/ Module  : Persons: Others
   Root cause: Data fix done to update the Previous Adoption Date in Persons tab to be 11/07/2006
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update person set preadoptiondate = '2006-11-07 00:00:00.000',
updatedby = 'CJAMS-58219', updatedon = now()
where personid = '26fb5bd2-b676-481f-9b8c-88f5325def8b' and activeflag = 1;
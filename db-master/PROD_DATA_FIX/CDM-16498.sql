 /*
  Issue Description: CDM-16498  CIS Number
   Category/ Module  :  Person Profile
   Root cause: CIS NO is missing
  Fix provided :
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

 update person set cisclientid=481046656 , updatedby='CDM-16498', updatedon=now() where cjamspid=4206073;

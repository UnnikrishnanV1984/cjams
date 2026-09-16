 /*
  Issue Description: CDM-24945  CIS Number
   Category/ Module  :  Person Profile
   Root cause: CIS NO is missing
  Fix provided :
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

 update person set cisclientid=477006924 , updatedby='CDM-24945', updatedon=now() where cjamspid=4397816;
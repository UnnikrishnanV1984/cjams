/*
  Issue Description:  CIDM-9270
   Category/ Module  :  
   Root cause:  Created an adhoc report and removed all the blank program assignment if any.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update personprogramarea set activeflag = 0,updatedon = now(),updatedby= 'CIDM-9270' where programkey IS NULL 
AND subprogramkey IS NULL and activeflag = 1; 

update personprogramarea set activeflag = 0,updatedon = now(),updatedby= 'CIDM-9270' where programkey IS NULL 
AND subprogramkey is not NULL and activeflag = 1;
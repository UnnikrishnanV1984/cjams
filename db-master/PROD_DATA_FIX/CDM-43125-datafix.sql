/*
  Issue Description:  CDM-42135
   Category/ Module  :  Assessments: Other
   Root cause: User error to remove the personprogramarea
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: NA
*/

update personprogramarea
set activeflag = 0,updatedby ='CDM-43125',updatedon =now()
where personprogramid='993699b8-7f23-4cbf-9dc3-3f4896e63769' and activeflag = 1;
/*
  Issue Description:  CDM-43911
   Category/ Module  :  Assignments
   Root cause: Child data not binding in assessment screen due to error in migration data
   Pull request# for code fix: 
   Reason why no related code fix: Data migration issue, Instead of array data string value passed for safeccaregivers column
*/

update assessmentsubmission ass set datavalue= '[]', updatedby='CJAMS-57910', updatedon = now() 
where ass.assessmentid = 'c96720a7-aa93-4765-aa9f-152bb209963f' 
      and ass.submissionid = '1171608' 
      and ass.activeflag = 1 
      and ass.datakey = 'safeccaregivers'
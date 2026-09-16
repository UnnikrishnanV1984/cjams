/* 
    Issue Description: CJAMS-61062
  Category/ Module: Services: Other
  Root cause: User request to update the overdue reason for Alleged victim,
Alleged Victim Unavailable
Attempted Face to Face
3-4 Attempts
  Fix provided : data fix provided to update the overdue reason for Alleged victim
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VAVU',
    cpsresponsetimerreason2 = 'VAFF',
    cpsresponsetimerreason3 = 'V34F',
    updatedon = now(),
    updatedby = 'CJAMS-59773'
where cpsresponsetimeractionsid = 'b8aa8262-f92a-40e9-90a9-a7668dcaf234'
and intakeserviceid = '113df8d9-8a8a-4eb6-9537-d13188b38ebc'
and activeflag = 1;
/* 
  Issue Description: CDM-40126
  Category/ Module  : Child Removal
  Root cause: User error to remove the draft child removal
  Pull request# for code fix: 
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/

update 	cjams.intakeservreqchildremoval
set    activeflag = 0, updatedby = 'CDM-40126',
		updatedon = now()
where personid = 'aeb4f8e5-8c61-4c12-b9f5-813c7d7294dc' and	
intakeservreqchildremovalid = '40168cdc-1a27-4712-9960-6f58d178458a' and activeflag = 1 ;

